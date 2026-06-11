// features/notifications/domain/entities/notification_entity.dart
enum NotificationType { order, discount, payment, system }

class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final bool isRead;
  final NotificationType type;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
    this.isRead = false,
    this.type = NotificationType.system,
  });

  NotificationEntity copyWith({bool? isRead}) {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      data: data,
      receivedAt: receivedAt,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}