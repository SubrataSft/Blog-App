
class CommentModel {
  final int id;
  final int postId;
  final int userId;
  final String user;
  final String comment;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.user,
    required this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: int.tryParse(json["id"].toString()) ?? 0,
      postId: int.tryParse(json["post_id"].toString()) ?? 0,
      userId: int.tryParse(json["user_id"].toString()) ?? 0,
      user: json["author_name"] ?? "Unknown",
      comment: json["content"] ?? "",
    );
  }
}
