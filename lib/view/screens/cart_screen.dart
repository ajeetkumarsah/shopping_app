import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/home_controller.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/view/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctlr) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Total Price : ${ctlr.totalPrice}'),
            centerTitle: true,
          ),
          body: ctlr.cartProducts.isEmpty && ctlr.isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: .5, color: Colors.blue)
              : ListView.builder(
                  itemCount: ctlr.cartProducts.length,
                  itemBuilder: (_, i) {
                    ProductModel item = ctlr.cartProducts[i];
                    return CartItem(
                      item: item,
                      onAddTap: () => ctlr.onAddProductToCart(item),
                      isCartItem: true,
                      onRemoveTap: () => ctlr.onRemoveProductFromCart(item),
                    );
                  },
                ),
        );
      },
    );
  }
}
