class PostModel {
  final String? uid;
  final int mood;
  final String content;
  final String creatorUid;
  final String creator;
  final int createdAt;

  PostModel({
    this.uid,
    required this.mood,
    required this.content,
    required this.creatorUid,
    required this.creator,
    required this.createdAt,
  });

  PostModel.formJson({
    String? uid,
    required Map<String, dynamic> json,
  })  : uid = json["uid"],
        mood = json["mood"],
        content = json["content"],
        creatorUid = json["creatorUid"],
        createdAt = json["createdAt"],
        creator = json["creator"];

  Map<String, dynamic> toJson(uid) {
    return {
      "uid": uid,
      "mood": mood,
      "content": content,
      "creatorUid": creatorUid,
      "creator": creator,
      "createdAt": createdAt,
    };
  }
}
