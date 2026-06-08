class NotificationEntity {
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime receivedAt;

  NotificationEntity({
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
  });
}
