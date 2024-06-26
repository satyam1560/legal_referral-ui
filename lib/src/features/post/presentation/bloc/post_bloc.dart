import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:legal_referral_ui/src/core/config/config.dart';
import 'package:legal_referral_ui/src/core/utils/utils.dart';
import 'package:legal_referral_ui/src/features/post/data/data.dart';
import 'package:legal_referral_ui/src/features/post/domain/domain.dart';
import 'package:legal_referral_ui/src/features/post/domain/usecases/post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required PostUsecase postUsecase})
      : _postUsecase = postUsecase,
        super(PostState.initial()) {
    on<FileAdded>(_onFileAdded);
    on<FileRemoved>(_onFileRemoved);
    on<PostCreated>(_onPostCreated);
  }

  final PostUsecase _postUsecase;

  FutureOr<void> _onFileAdded(event, emit) async {
    final files = await ImageUtil.pickMultipleImages();

    if (files.isNotEmpty) {
      emit(
        state.copyWith(
          files: files,
          postType: PostType.image,
        ),
      );
    }
  }

  FutureOr<void> _onFileRemoved(event, emit) async {
    final index = event.index;
    final files = List<File>.from(state.files);
    if (index != null && index < files.length) {
      files.removeAt(index);
      emit(
        state.copyWith(
          files: files,
        ),
      );
    }
  }

  FutureOr<void> _onPostCreated(event, emit) async {
    emit(
      state.copyWith(
        status: PostStatus.loading,
      ),
    );

    final response = await _postUsecase.createPost(
      post: CreatePostReq(
        ownerId: event.ownerId,
        title: event.title,
        content: 'post content',
        type: PostType.image,
        files: state.files,
      ),
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            status: PostStatus.failure,
            failure: failure,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            status: PostStatus.success,
          ),
        );
      },
    );
  }
}
