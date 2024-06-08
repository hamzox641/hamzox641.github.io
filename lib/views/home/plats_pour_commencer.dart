import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';

import 'package:glaz/hooks/fetch_All_restaurants.dart';
import 'package:glaz/models/restaurant_model.dart';
import 'package:glaz/views/home/widgets/plats_tile.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class PlatPourCommencer extends HookWidget {
  const PlatPourCommencer({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllRestaurants("41007428");
    List<RestaurantModel>? restaurants = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kOffWhite,
            title: ReusableText(
                text: "Les Plats pour commencer",
                style: appStyle(13, kGray, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: isLoading
              ? FoodsListShimmer()
              : Padding(
                  padding: EdgeInsets.all(12.w),
                  child: ListView(
                      children: List.generate(restaurants!.length, (i) {
                    RestaurantModel restaurant = restaurants[i];
                    return PlatsTile(
                      restaurant: restaurant,
                    );
                  })),
                ),
        ));
  }
}
