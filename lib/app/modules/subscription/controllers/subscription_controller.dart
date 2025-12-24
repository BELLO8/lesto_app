import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final selectedPlan = 0.obs; // 0 for Monthly, 1 for Annual

  void selectPlan(int index) {
    selectedPlan.value = index;
  }

  void subscribe() {
    // Logic for subscription process
  }
}
