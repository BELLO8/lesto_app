import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import '../controllers/notifications_controller.dart';
import 'package:intl/intl.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.grey.shade800),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontFamily: 'GilroyBold',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(HugeIcons.strokeRoundedNotification01,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text(
                  "Aucune notification pour le moment",
                  style: TextStyle(
                      color: Colors.grey.shade500, fontFamily: 'Gilroy'),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _buildNotificationItem(notification);
          },
        );
      }),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white
            : PrimaryColor.primary100.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead
              ? Colors.grey.shade100
              : PrimaryColor.primary100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notification.isRead
                  ? Colors.grey.shade50
                  : PrimaryColor.primary100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              HugeIcons.strokeRoundedNotification02,
              color: notification.isRead
                  ? Colors.grey.shade400
                  : PrimaryColor.primary600,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'GilroyBold',
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('HH:mm').format(notification.time),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontFamily: 'Gilroy',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
