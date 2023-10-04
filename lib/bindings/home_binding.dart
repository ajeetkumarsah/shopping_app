import 'package:get/get.dart';
import 'package:new_app/controller/home_controller.dart';
import 'package:new_app/controller/product_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
