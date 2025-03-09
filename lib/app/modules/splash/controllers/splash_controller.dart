import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      if (storage.read('token') == null && storage.read('onboarding') != null) {
        Get.offAndToNamed(Routes.AUTH_LOGIN);
      } else if (storage.read('onboarding') == null) {
        storage.write('onboarding', 'onboard');
        Get.offAndToNamed(Routes.ONBOARDING);
      } else {
        Get.offAndToNamed(Routes.HOME);
      }
    });
  }
}
