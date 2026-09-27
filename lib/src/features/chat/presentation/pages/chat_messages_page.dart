import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:legal_referral_ui/src/core/common_widgets/widgets.dart';
import 'package:legal_referral_ui/src/core/config/config.dart';
import 'package:legal_referral_ui/src/core/constants/constants.dart';
import 'package:legal_referral_ui/src/core/utils/utils.dart';
import 'package:legal_referral_ui/src/features/auth/presentation/presentation.dart';
import 'package:legal_referral_ui/src/features/chat/domain/domain.dart';
import 'package:legal_referral_ui/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:toastification/toastification.dart';

class ChatMessagesPage extends StatefulWidget {
  const ChatMessagesPage({
    required this.recipientId,
    super.key,
  });

  final String recipientId;

  static const String name = 'ChatMessagesPage';

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  final _authBloc = getIt<AuthBloc>();
  final _chatBloc = getIt<ChatBloc>();
  final _focusNode = FocusNode();
  final _textEditingController = TextEditingController();
  late final InMemoryChatController _chatController;

  @override
  void initState() {
    super.initState();

    _chatController = InMemoryChatController();

    final currentUserId = _authBloc.state.user?.userId;
    if (currentUserId == null) return;

    _chatBloc.add(
      ChatRoomCreated(
        senderId: currentUserId,
        recipientId: widget.recipientId,
      ),
    );
  }

  /// Syncs the bloc's message list into the ChatController whenever
  /// state.messages changes.
  Future<void> _syncMessages(List<ChatMessage> messages) async {
    final coreMessages = messages.map(_toCoreMessage).toList();
    await _chatController.setMessages(coreMessages);
  }

  /// Converts your domain ChatMessage to flutter_chat_core TextMessage.
  TextMessage _toCoreMessage(ChatMessage m) {
    return TextMessage(
      id: m.messageId.toString(),
      authorId: m.senderId,
      // createdAt: m.createdAt != null
      //     ? DateTime.parse(m.createdAt!).toUtc()
      //     : DateTime.now().toUtc(),
      text: m.message,
      // Store the replied message text in metadata so
      // _textMessageBuilder can access it.
      metadata: m.repliedMessage != null
          ? {'repliedText': m.repliedMessage!.message}
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _authBloc.state.user;
    if (currentUser == null) {
      return const Scaffold(body: CustomLoadingIndicator());
    }

    return BlocConsumer<ChatBloc, ChatState>(
      bloc: _chatBloc,
      listener: (context, state) {
        if (state.status == ChatStatus.failure) {
          ToastUtil.showToast(
            context,
            title: 'Error',
            description: state.failure?.message ?? 'something went wrong',
            type: ToastificationType.error,
          );
        }

        // Sync messages into the controller whenever state updates.
        if (state.status == ChatStatus.success) {
          _syncMessages(state.chatMessages.whereType<ChatMessage>().toList());
        }
      },
      builder: (context, state) {
        final name = '${state.currentChatRoom.firstName ?? ''}'
            ' ${state.currentChatRoom.lastName ?? ''}';

        return Scaffold(
          appBar: AppBar(
            title: Text(name),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: state.status == ChatStatus.success
              ? Column(
                  children: [
                    Expanded(
                      child: chat_ui.Chat(
                        chatController: _chatController,
                        currentUserId: currentUser.userId ?? '',
                        resolveUser: (id) async {
                          // Return user info for avatars/names.
                          // Adapt this to your actual user lookup if needed.
                          return User(id: id);
                        },
                        onMessageSend: (text) {
                          if (text.trim().isEmpty) return;
                          _chatBloc.add(
                            ChatMessageSent(
                              chatRoom: state.currentChatRoom,
                              message: ChatMessage(
                                senderId: currentUser.userId ?? '',
                                recipientId: state.currentChatRoom.userId,
                                parentMessageId:
                                    state.parentMessage?.messageId ?? 0,
                                message: text,
                                roomId: state.currentChatRoom.roomId,
                                repliedMessage: state.parentMessage,
                              ),
                            ),
                          );
                        },
                        onMessageTap: (context, message,
                            {required details, required index}) {},
                        timeFormat: DateFormat('HH:mm'),
                        // builders: chat_ui.Builders(
                        //   textMessageBuilder: (context,
                        //       {required message, required index}) {
                        //     return _textMessageBuilder(
                        //       message as TextMessage,
                        //     );
                        //   },
                        //   bubbleBuilder: (context,
                        //       {required message,
                        //       required index,
                        //       required child}) {
                        //     return _bubbleBuilder(
                        //       child,
                        //       message: message,
                        //       currentUserId: currentUser.userId ?? '',
                        //     );
                        //   },
                        // ),
                      ),
                    ),
                    // Custom bottom input bar — replaces customBottomWidget
                    _buildInputBar(state, currentUser),
                  ],
                )
              : const CustomLoadingIndicator(),
        );
      },
    );
  }

  Widget _buildInputBar(ChatState state, dynamic currentUser) {
    return SizedBox(
      height: kBottomNavigationBarHeight +
          26.h +
          (state.parentMessage != null
              ? (state.parentMessage!.message.length > 8 ? 44.h : 24.h)
              : 0),
      child: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.parentMessage != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Repling to: ${state.parentMessage?.message}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    focusNode: _focusNode,
                    hintText: 'Your message here',
                    controller: _textEditingController,
                    onChanged: (value) {},
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    IconStringConstants.send,
                    colorFilter: const ColorFilter.mode(
                      Colors.blue,
                      BlendMode.srcIn,
                    ),
                    height: 24.h,
                    width: 24.w,
                  ),
                  onPressed: () {
                    final text = _textEditingController.text;
                    if (text.trim().isEmpty) return;
                    _chatBloc.add(
                      ChatMessageSent(
                        chatRoom: state.currentChatRoom,
                        message: ChatMessage(
                          senderId: currentUser.userId ?? '',
                          recipientId: state.currentChatRoom.userId,
                          parentMessageId:
                              state.parentMessage?.messageId ?? 0,
                          message: text,
                          roomId: state.currentChatRoom.roomId,
                          repliedMessage: state.parentMessage,
                        ),
                      ),
                    );
                    _textEditingController.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _replyToMessage({required ChatMessage parentMessage}) {
    _chatBloc.add(ParentMesssgeUpdated(message: parentMessage));
    FocusScope.of(context).requestFocus(_focusNode);
  }

  Widget _textMessageBuilder(TextMessage message) {
    final repliedText = message.metadata?['repliedText'] as String?;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (repliedText != null)
            Text(
              'Replied to: $repliedText',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(
              message.text,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    final parentMessage = ChatMessage(
                      messageId: int.tryParse(message.id) ?? 0,
                      senderId: message.authorId,
                      recipientId: message.authorId,
                      parentMessageId: 0,
                      message: message.text,
                      roomId: _chatBloc.state.currentChatRoom.roomId,
                    );
                    _replyToMessage(parentMessage: parentMessage);
                  },
                  child: Row(
                    children: [
                      SvgButton(
                        imagePath: IconStringConstants.reply2,
                        color: Colors.grey.shade700,
                        onPressed: () {
                          final parentMessage = ChatMessage(
                            messageId: int.tryParse(message.id) ?? 0,
                            senderId: message.authorId,
                            recipientId: message.authorId,
                            parentMessageId: 0,
                            message: message.text,
                            roomId: _chatBloc.state.currentChatRoom.roomId,
                          );
                          _replyToMessage(parentMessage: parentMessage);
                        },
                        height: 16.8.h,
                        width: 16.8.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Reply',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat.jm().format(message.createdAt?.toLocal()?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubbleBuilder(
    Widget child, {
    required Message message,
    required String currentUserId,
  }) {
    final isCurrentUser = message.authorId == currentUserId;
    return Bubble(
      color: !isCurrentUser ? Colors.white : const Color(0XFFF9FFE7),
      nip: isCurrentUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
      child: child,
    );
  }

  @override
  void dispose() {
    _chatController.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}