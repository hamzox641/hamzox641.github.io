import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/categories.dart';
import 'package:glaz/views/Categories/category_page.dart';

class CategoryTitle extends StatelessWidget {
  CategoryTitle({
    super.key,
    required this.category,
  });
  CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => const CategoryPage(),
            transition: Transition.fadeIn,
            duration: const Duration(microseconds: 900));
      },
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: kGrayLight,
        child: Image.network(
          category.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
      title: ReusableText(
        text: category.title,
        style: appStyle(12, kGray, FontWeight.normal),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: kGray,
        size: 15,
      ),
    );
  }
}
