    // // features/notifications/presentation/widgets/notification_banner.dart
    // class NotificationBanner extends StatefulWidget {
    //   final NotificationEntity notification;
    //   final VoidCallback onDismiss;
    //   final VoidCallback onTap;

    //   const NotificationBanner({
    //     super.key,
    //     required this.notification,
    //     required this.onDismiss,
    //     required this.onTap,
    //   });

    //   @override
    //   State<NotificationBanner> createState() => _NotificationBannerState();
    // }

    // class _NotificationBannerState extends State<NotificationBanner>
    //     with SingleTickerProviderStateMixin {
    //   late AnimationController _controller;
    //   late Animation<Offset> _slideAnim;

    //   @override
    //   void initState() {
    //     super.initState();
    //     _controller = AnimationController(
    //       vsync: this,
    //       duration: const Duration(milliseconds: 350),
    //     );
    //     _slideAnim = Tween<Offset>(
    //       begin: const Offset(0, -1),
    //       end: Offset.zero,
    //     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    //     _controller.forward();

    //     // auto-dismiss after 4 seconds
    //     Future.delayed(const Duration(seconds: 4), () {
    //       if (mounted) _dismiss();
    //     });
    //   }

    //   void _dismiss() {
    //     _controller.reverse().then((_) => widget.onDismiss());
    //   }

    //   @override
    //   void dispose() {
    //     _controller.dispose();
    //     super.dispose();
    //   }

    //   @override
    //   Widget build(BuildContext context) {
    //     return SlideTransition(
    //       position: _slideAnim,
    //       child: GestureDetector(
    //         onTap: widget.onTap,
    //         child: SafeArea(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //             child: Material(
    //               elevation: 6,
    //               borderRadius: BorderRadius.circular(16),
    //               color: Theme.of(context).colorScheme.surfaceContainerHigh,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(16),
    //                 child: Row(
    //                   children: [
    //                     const Icon(Icons.notifications_rounded, size: 28),
    //                     const SizedBox(width: 12),
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           Text(
    //                             widget.notification.title,
    //                             style: Theme.of(context).textTheme.titleSmall
    //                                 ?.copyWith(fontWeight: FontWeight.w600),
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                           const SizedBox(height: 2),
    //                           Text(
    //                             widget.notification.body,
    //                             style: Theme.of(context).textTheme.bodySmall,
    //                             maxLines: 2,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     IconButton(
    //                       onPressed: _dismiss,
    //                       icon: const Icon(Icons.close, size: 18),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // }