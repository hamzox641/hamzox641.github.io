import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/shimmers/nearby_shimmer.dart';
import 'package:glaz/hooks/fetch_restaurant.dart';
import 'package:glaz/models/restaurant_model.dart';
import 'package:glaz/views/home/widgets/pour_commencer_widget.dart';

class PourCommencerListe extends HookWidget {
  const PourCommencerListe({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurants("41007428");
    List<RestaurantModel>? restaurants = hookResults.data;
    final isLoading = hookResults.isLoading;
    return isLoading
        ? NearbyShimmer()
        : Container(
            height: 190.h,
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(restaurants?.length ?? 0, (i) {
                  RestaurantModel restaurant = restaurants![i];
                  return PourCommencerWidget(
                    image: restaurant.imageUrl,
                    logo: restaurant.logoUrl,
                    title: restaurant.title,
                    time: restaurant.time,
                    rating: "596",
                  );
                })));
  }
}
