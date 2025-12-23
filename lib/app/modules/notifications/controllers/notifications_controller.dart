import 'package:get/get.dart';

class NotificationModel {
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    // Mock notifications for now
    notifications.value = [
      NotificationModel(
        title: "Nouveau menu disponible",
        message: "Votre menu de la semaine est prêt ! Découvrez-le maintenant.",
        time: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        title: "Rappel courses",
        message: "N'oubliez pas de faire vos courses pour demain.",
        time: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        title: "Plat favori",
        message: "Une nouvelle recette de 'Pizza' a été ajoutée.",
        time: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ];
  }

  void markAsRead(int index) {
    // Logic to mark as read
  }
}
