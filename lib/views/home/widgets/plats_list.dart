import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/shimmers/nearby_shimmer.dart';
import 'package:glaz/hooks/fetch_Foods.dart';
import 'package:glaz/models/foods_model.dart';
import 'package:glaz/views/food/food_page.dart';

import 'package:glaz/views/home/widgets/suite_widget.dart';

class PlatList extends HookWidget {
  const PlatList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoods("41007428");
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Container(
        height: 184.h,
        child: isLoading
            ? const NearbyShimmer()
            : ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(foods?.length ?? 0, (i) {
                  FoodsModel food = foods![i];
                  return PlatsWidget(
                    onTap: () {
                      Get.to(() => FoodPage(food: food));
                    },
                    image: food.imageUrl[0],
                    title: food.title,
                    time: food.time,
                    price: food.price.toStringAsFixed(2),
                    rating: food.rating,
                  );
                })));
  }
}
