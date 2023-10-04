import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/view/screens/cart_screen.dart';
import 'package:new_app/view/widgets/cart_item.dart';

import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctlr) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => Get.to(const CartScreen()),
                  icon: const Icon(Icons.shopping_cart)),
            ],
          ),
          body: ctlr.products.isEmpty && ctlr.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.blue),
                )
              : ListView.builder(
                  itemCount: ctlr.products.length,
                  itemBuilder: (_, i) {
                    ProductModel item = ctlr.products[i];
                    return CartItem(
                      item: item,
                      onAddTap: () => ctlr.onAddProductToCart(item),
                    );
                  },
                ),
        );
      },
    );
  }
}
