import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_category_foods.dart';

import 'package:glaz/models/foods_model.dart';
import 'package:glaz/views/home/widgets/suite_tile.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({Key? key});

  @override
  Widget build(BuildContext context) {
    final hookresult = useFetchFoodsCategory("41007426");
    final List<FoodsModel> foods = hookresult.data ?? [];
    final isLoading = hookresult.isLoading;

    return SizedBox(
      width: width,
      height: height,
      child: isLoading
          ? const FoodsListShimmer()
          : Padding(
              padding: EdgeInsets.all(12.h),
              child: ListView(
                children: List.generate(foods.length, (i) {
                  FoodsModel food = foods[i];
                  return SuiteTile(
                    food: food,
                  );
                }),
              ),
            ),
    );
  }
}
