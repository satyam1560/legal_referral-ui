// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiscussionMessage _$DiscussionMessageFromJson(Map<String, dynamic> json) =>
    _DiscussionMessage(
      senderId: json['sender_id'] as String,
      message: json['message'] as String,
      repliedMessage: json['replied_message'] == null
          ? null
          : DiscussionMessage.fromJson(
              json['replied_message'] as Map<String, dynamic>,
            ),
      discussionId: (json['discussion_id'] as num).toInt(),
      sentAt: _$JsonConverterFromJson<String, DateTime>(
        json['sent_at'],
        const DateTimeJsonConverter().fromJson,
      ),
      parentMessageId: (json['parent_message_id'] as num?)?.toInt(),
      messageId: (json['message_id'] as num?)?.toInt(),
      senderFirstName: json['sender_first_name'] as String?,
      senderLastName: json['sender_last_name'] as String?,
      senderAvatarImg: json['sender_avatar_image'] as String?,
    );

Map<String, dynamic> _$DiscussionMessageToJson(_DiscussionMessage instance) =>
    <String, dynamic>{
      'sender_id': instance.senderId,
      'message': instance.message,
      'replied_message': ?instance.repliedMessage,
      'discussion_id': instance.discussionId,
      'sent_at': ?_$JsonConverterToJson<String, DateTime>(
        instance.sentAt,
        const DateTimeJsonConverter().toJson,
      ),
      'parent_message_id': ?instance.parentMessageId,
      'message_id': ?instance.messageId,
      'sender_first_name': ?instance.senderFirstName,
      'sender_last_name': ?instance.senderLastName,
      'sender_avatar_image': ?instance.senderAvatarImg,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
