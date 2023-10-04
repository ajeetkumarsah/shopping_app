import 'package:get/get.dart';
import 'package:new_app/bindings/home_binding.dart';
import 'package:new_app/view/screens/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.PRODUCT,
    //   page: () => ProductListScreen(),
    //   binding: HomeBinding(),
    // ),
  ];
}
