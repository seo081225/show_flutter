import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_flutter/features/posts/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadPost(PostModel data) async {
    final postsDoc = _db.collection("posts").doc();
    postsDoc.set(data.toJson(postsDoc.id));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts({
    int? lastItemCreatedAt,
  }) {
    final query =
        _db.collection("posts").orderBy("createdAt", descending: true);

    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> deletePost(String uid) async {
    await _db.collection("posts").doc(uid).delete();
  }
}

final postRepository = Provider((ref) => PostRepository());
