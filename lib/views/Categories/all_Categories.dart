import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';

import 'package:glaz/hooks/fetch_All_categories.dart';
import 'package:glaz/models/categories.dart';

import '../../common/app_style.dart';

import 'widgets/category_title.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllCategories();
    List<CategoriesModel>? categories = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kOffWhite,
            title: ReusableText(
              text: "ALL Categories",
              style: appStyle(12, kGray, FontWeight.w600),
            )),
        body: BackGroundContainer(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            height: height,
            child: isLoading
                ? FoodsListShimmer()
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(categories!.length, (i) {
                      CategoriesModel category = categories[i];
                      return CategoryTitle(category: category);
                    }),
                  ),
          ),
        ));
  }
}
