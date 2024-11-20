import 'package:get/get.dart';

import '../modules/FoodDetail/bindings/food_detail_binding.dart';
import '../modules/FoodDetail/views/food_detail_view.dart';
import '../modules/GenerateMenu/bindings/generate_menu_binding.dart';
import '../modules/GenerateMenu/views/generate_menu_view.dart';
import '../modules/GenerateMenuFilter/bindings/generate_menu_filter_binding.dart';
import '../modules/GenerateMenuFilter/views/generate_menu_filter_view.dart';
import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/register/bindings/auth_register_binding.dart';
import '../modules/auth/register/views/auth_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_LOGIN,
      page: () => const AuthLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_REGISTER,
      page: () => const AuthRegisterView(),
      binding: AuthRegisterBinding(),
    ),
    GetPage(
      name: _Paths.FOOD_DETAIL,
      page: () => const FoodDetailView(),
      binding: FoodDetailBinding(),
    ),
    GetPage(
      name: _Paths.GENERATE_MENU,
      page: () => const GenerateMenuView(),
      binding: GenerateMenuBinding(),
    ),
    GetPage(
      name: _Paths.GENERATE_MENU_FILTER,
      page: () => const GenerateMenuFilterView(),
      binding: GenerateMenuFilterBinding(),
    ),
  ];
}
