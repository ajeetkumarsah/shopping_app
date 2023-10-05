import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/controller/home_controller.dart';
import 'package:new_app/helper/app_colors.dart';
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary),
              ),
            ),
            title: Text(
              'Your cart ',
              style: GoogleFonts.abel(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: ctlr.cartProducts.isEmpty && ctlr.isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: .5, color: Colors.blue)
              : ctlr.cartProducts.isEmpty
                  ? Center(
                      child: Text(
                        'Your cart is empty!',
                        style: GoogleFonts.abel(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: ctlr.cartProducts.length,
                      padding: const EdgeInsets.only(bottom: 60),
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
          bottomSheet: Container(
            color: AppColors.lightGrey,
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total : ${ctlr.totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.acme(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Checkout',
                        style: GoogleFonts.actor(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12, right: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          CupertinoIcons.forward,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
