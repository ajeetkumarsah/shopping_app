import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/helper/app_colors.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/utils/png_files.dart';
import 'package:new_app/view/screens/cart_screen.dart';
import 'package:new_app/view/widgets/cart_item.dart';
import 'package:new_app/view/widgets/category_item.dart';
import 'package:new_app/view/widgets/product_item.dart';

import '../../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctlr) {
        return Scaffold(
            backgroundColor: Colors.white,
            key: controller.scaffoldKey,
            drawer: const Drawer(),
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => ctlr.openDrawer(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Image.asset(
                    PngFiles.menu,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              title: Text(
                'wisCart',
                style: GoogleFonts.abel(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(100),
                //     child: Image.network(
                //       'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=700&q=60',
                //       height: 40,
                //       width: 32,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => Get.to(const CartScreen()),
                      icon: const Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.black87,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 12,
                      child: ctlr.cartProducts.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 0),
                              child: Text(
                                '${ctlr.cartProducts.length}',
                                style: GoogleFonts.acme(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 6),
                    child: Text(
                      'We make online \nSelling superbly easy.',
                      style: GoogleFonts.acme(
                        fontSize: 22,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            // height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.lightGrey,
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Search',
                              prefix: const Icon(
                                CupertinoIcons.search,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.lightGrey,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            PngFiles.filter,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  titleWidget(title: 'Categories'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: ctlr.categories.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (_, i) {
                        String item = ctlr.categories[i];
                        return CategoryItem(
                          item: item,
                          isSelected: i == 0,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  titleWidget(title: 'Top Products', viewAll: true),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Text(
                              'Found \n${ctlr.products.length} Results',
                              style: GoogleFonts.actor(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ...ctlr.products
                            .map(
                              (product) => StaggeredGridTile.count(
                                crossAxisCellCount: 2,
                                mainAxisCellCount: 3,
                                child: ProductItem(
                                  product: product,
                                  onAddTap: () =>
                                      ctlr.onAddProductToCart(product),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            )

            //  ctlr.products.isEmpty && ctlr.isLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //             strokeWidth: 2, color: Colors.blue),
            //       )
            //     : ListView.builder(
            //         itemCount: ctlr.products.length,
            //         itemBuilder: (_, i) {
            //           ProductModel item = ctlr.products[i];
            //           return CartItem(
            //             item: item,
            //             onAddTap: () => ctlr.onAddProductToCart(item),
            //           );
            //         },
            //       ),
            );
      },
    );
  }

  Widget titleWidget({required String title, bool viewAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.actor(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          viewAll
              ? Text.rich(
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => debugPrint('==>onTap Wiew all Categories'),
                    children: [
                      TextSpan(
                        text: 'View All',
                        style: GoogleFonts.actor(
                          color: Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(
                        child: Container(
                          height: 18,
                          width: 18,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primary.withOpacity(.4),
                          ),
                          child: const Icon(
                            CupertinoIcons.forward,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
