class PostModel {
  final int mood;
  final String content;
  final String creatorUid;
  final String creator;
  final int createdAt;

  PostModel({
    required this.mood,
    required this.content,
    required this.creatorUid,
    required this.creator,
    required this.createdAt,
  });

  PostModel.formJson({
    required Map<String, dynamic> json,
  })  : mood = json["mood"],
        content = json["content"],
        creatorUid = json["creatorUid"],
        createdAt = json["createdAt"],
        creator = json["creator"];

  Map<String, dynamic> toJson() {
    return {
      "mood": mood,
      "content": content,
      "creatorUid": creatorUid,
      "creator": creator,
      "createdAt": createdAt,
    };
  }
}
