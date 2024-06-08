import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_category_foods.dart';
import 'package:glaz/models/foods_model.dart';
import 'package:glaz/views/home/widgets/suite_tile.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookresult = useFetchFoodsCategory("41007426");
    final List<FoodsModel> foods = hookresult.data ?? [];
    final isLoading = hookresult.isLoading;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          title: const Text("category page"),
        ),
        body: BackGroundContainer(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            height: height,
            child: isLoading
                ? FoodsListShimmer()
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
          ),
        ));
  }
}
