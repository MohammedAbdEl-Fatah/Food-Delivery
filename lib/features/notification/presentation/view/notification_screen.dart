// features/notifications/presentation/screens/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/di/servier_locator.dart';
import 'package:food_delivery/core/service/firebase_message_service.dart';

import '../../domain/entity/notification_entity.dart';
import '../cubit/notification_cubit.dart';
import '../widget/item_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        registerNotificationDependencies();
        return sl<NotificationCubit>()..init();
      },
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoadedState && state.unread.isNotEmpty) {
                return TextButton(
                  onPressed:
                      () => context.read<NotificationCubit>().markAllRead(),
                  child: const Text('Mark all read'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is! NotificationLoadedState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.notifications.isEmpty) {
            return const _EmptyState();
          }

          return CustomScrollView(
            slivers: [
              if (state.unread.isNotEmpty) ...[
                const _SectionHeader(label: 'New'),
                _NotificationSliver(notifications: state.unread),
              ],
              if (state.read.isNotEmpty) ...[
                const _SectionHeader(label: 'Earlier'),
                _NotificationSliver(notifications: state.read),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.4),
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}

class _NotificationSliver extends StatelessWidget {
  final List<NotificationEntity> notifications;
  const _NotificationSliver({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const Divider(height: 0, thickness: 0.5),
      itemBuilder: (context, index) {
        final n = notifications[index];
        return ItemNotification(
          notification: n,
          onTap: () {
            context.read<NotificationCubit>().markAsRead(n.id);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => NotificationDetailScreen(notification: n),
            //   ),
            // );
          },
          onDelete:
              () => context.read<NotificationCubit>().deleteNotification(n.id),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 56,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.25),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
