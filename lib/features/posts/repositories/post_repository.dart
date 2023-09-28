import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_flutter/features/posts/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadPost(PostModel data) async {
    _db.collection("posts").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts({
    int? lastItemCreatedAt,
  }) {
    final query = _db
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .limit(10);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }
}

final postRepository = Provider((ref) => PostRepository());
