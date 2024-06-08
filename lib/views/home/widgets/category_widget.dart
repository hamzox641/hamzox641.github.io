import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/category_controler.dart';
import 'package:glaz/models/categories.dart';
import 'package:glaz/views/Categories/all_Categories.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    super.key,
    required this.category,
  });

  CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return GestureDetector(
      onTap: () {
        if (controller.categoryValue == category.id) {
          controller.updateCategory = '';
          controller.updateTitle = '';
        } else if (category.value == 'more') {
          Get.to(() => const AllCategories(),
              transition: Transition.fadeIn,
              duration: const Duration(microseconds: 900));
        } else {
          controller.updateCategory = category.id;
          controller.updateCategory = category.title;
        }
      },
      child: Obx(
        () => Container(
          margin: EdgeInsets.only(right: 5.w),
          padding: EdgeInsets.only(top: 4.h),
          width: width * 0.19,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                  color: controller.categoryValue == category.id
                      ? kTertiary
                      : kOffWhite,
                  width: .5.w)),
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
                child: Image.network(
                  category.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              ReusableText(
                  text: category.title,
                  style: appStyle(12, kDark, FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
