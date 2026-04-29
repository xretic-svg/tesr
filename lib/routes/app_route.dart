import 'package:flutter/material.dart';
import '../presentation/splash_onboarding_screen/splash_onboarding_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';
import '../presentation/basket_screen/basket_screen.dart';
import '../presentation/favourites_screen/favourites_screen.dart';
import '../presentation/checkout_screen/checkout_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashOnboarding = '/splash-onboarding-screen';
  static const String home = '/home-screen';
  static const String settings = '/settings-screen';
  static const String productDetail = '/product-detail-screen';
  static const String basket = '/basket-screen';
  static const String favourites = '/favourites-screen';
  static const String checkout = '/checkout-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashOnboardingScreen(),
    splashOnboarding: (context) => const SplashOnboardingScreen(),
    home: (context) => const HomeScreen(),
    settings: (context) => const SettingsScreen(),
    productDetail: (context) => const ProductDetailScreen(),
    basket: (context) => const BasketScreen(),
    favourites: (context) => const FavouritesScreen(),
    checkout: (context) => const CheckoutScreen(),
  };
}
