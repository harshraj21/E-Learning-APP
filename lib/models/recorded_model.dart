class RecordedModel {
  final id;
  final int date;
  final String subject;
  final String title;
  final String description;
  final String url;
  final int schedule;
  final int expire;
  RecordedModel({
    this.id,
    required this.date,
    required this.subject,
    required this.title,
    required this.description,
    required this.url,
    required this.schedule,
    required this.expire,
  });
}
