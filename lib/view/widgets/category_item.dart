import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/helper/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  const CategoryItem({super.key, required this.item, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: !isSelected ? Colors.white : AppColors.primary,
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      margin: const EdgeInsets.only(right: 12),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 2),
      alignment: Alignment.center,
      child: Text(
        item,
        style: GoogleFonts.actor(
          color: isSelected ? Colors.white : AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
