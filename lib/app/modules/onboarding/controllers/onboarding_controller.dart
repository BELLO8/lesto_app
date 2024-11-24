import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    // storage.write('onboarding', 'onboard');
  }
}
