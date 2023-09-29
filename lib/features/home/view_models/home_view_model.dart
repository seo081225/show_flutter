import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_flutter/features/posts/models/post_model.dart';
import 'package:show_flutter/features/posts/repositories/post_repository.dart';

class HomeViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _list = [];

  Future<List<PostModel>> _fetchPosts({
    int? lastItemCreatedAt,
  }) async {
    final result = await _repository.fetchPosts(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final posts = result.docs.map(
      (doc) => PostModel.formJson(json: doc.data()),
    );
    return posts.toList();
  }

  @override
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepository);
    _list = await _fetchPosts(lastItemCreatedAt: null);
    return _list;
  }
}

final homeviewProvider = AsyncNotifierProvider<HomeViewModel, List<PostModel>>(
  () => HomeViewModel(),
);

final postProvider = StreamProvider.autoDispose<List<PostModel>>((ref) {
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection("posts")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => PostModel.formJson(
                json: e.data(),
              ),
            )
            .toList(),
      );
});
