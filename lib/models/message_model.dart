class MessageModel {
  bool isMe;
  String username;
  String message;
  String id;

  MessageModel({
    this.isMe = false,
    required this.username,
    required this.message,
    required this.id,
  });
}
