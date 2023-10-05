import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/helper/app_colors.dart';
import 'package:new_app/model/product_model.dart';

class CartItem extends StatelessWidget {
  final ProductModel item;
  final void Function()? onAddTap;
  final void Function()? onRemoveTap;
  final bool isCartItem;
  const CartItem(
      {super.key,
      required this.item,
      this.onRemoveTap,
      this.onAddTap,
      this.isCartItem = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 90,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.image ?? '',
                width: double.infinity,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 1,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                item.title ?? 'Title',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${item.description}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '\u{20B9} ${item.price}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.actor(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.primary,
                        ),
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            iconButton(
                                icon: CupertinoIcons.minus, onTap: onRemoveTap),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '${item.quantity}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.actor(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            iconButton(
                                icon: CupertinoIcons.add, onTap: onAddTap),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconButton({required IconData icon, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey[300]!,
          //     offset: const Offset(0, 8),
          //     blurRadius: 6,
          //     spreadRadius: 6,
          //   ),
          // ],
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 14,
        ),
      ),
    );
  }
}

//  isCartItem
//                           ? Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.blue,
//                               ),
//                               child: Row(
//                                 children: [
//                                   IconButton(
//                                     onPressed: onRemoveTap,
//                                     icon: const Icon(Icons.remove,
//                                         color: Colors.white),
//                                   ),
//                                   Text(
//                                     '${item.quantity}',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: onAddTap,
//                                     icon: const Icon(Icons.add,
//                                         color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : InkWell(
//                               onTap: onAddTap,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   color: Colors.blue,
//                                 ),
//                                 margin: const EdgeInsets.only(top: 12),
//                                 alignment: Alignment.center,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 12),
//                                 child: const Text(
//                                   'Add to Cart',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
