class NoticeModel {
  final id;
  final int dateStamp;
  final String title;
  final String message;
  NoticeModel({
    this.id,
    required this.dateStamp,
    required this.title,
    required this.message,
  });
}
