import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/common/error_page.dart';
import 'package:twitter/common/loading_page.dart';
import 'package:twitter/constants/constants.dart';
import 'package:twitter/features/auth/controller/auth_controller.dart';
import 'package:twitter/features/notifications/controller/notification_controller.dart';
import 'package:twitter/features/notifications/widgets/notification_tile.dart';
import 'package:twitter/models/notification_model.dart' as model;

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: currentUser == null
          ? const Loader()
          : ref.watch(getNotificationsProvider(currentUser.uid)).when(
                data: (notifications) {
                  return ref.watch(getLatestNotificationProvider).when(
                        data: (data) {
                          if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.notificationsId}.documents.*.create',
                          )) {
                            final latestNotif =
                                model.Notification.fromMap(data.payload);
                            if (latestNotif.uid == currentUser.uid) {
                              notifications.insert(0, latestNotif);
                            }
                          }

                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                notification: notification,
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () {
                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                notification: notification,
                              );
                            },
                          );
                        },
                      );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
    );
  }
}
