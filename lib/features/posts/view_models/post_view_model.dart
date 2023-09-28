import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/features/authentication/repository/authentication_repository.dart';
import 'package:show_flutter/features/posts/models/post_model.dart';
import 'package:show_flutter/features/posts/repositories/post_repository.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final PostRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(postRepository);
  }

  Future<void> uploadPost(BuildContext context) async {
    final form = ref.read(postForm);
    final user = ref.read(authRepository).user;
    if (user != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          await _repository.uploadPost(
            PostModel(
              mood: form["mood"],
              content: form["content"],
              creatorUid: user.uid,
              creator: "",
              createdAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );
        },
      );
      context.go("/home");
    }
  }
}

final postForm = StateProvider((ref) => {});

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);
