import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_all_foods.dart';
import 'package:glaz/models/foods_model.dart';
import 'package:glaz/views/home/widgets/suite_tile.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class PlatsSuite extends HookWidget {
  const PlatsSuite({super.key});

  @override
  Widget build(BuildContext context) {
    final hookresults = useFetchAllFoods("41007428");
    List<FoodsModel>? foods = hookresults.data;
    final isLoading = hookresults.isLoading;
    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            backgroundColor: kOffWhite,
            title: ReusableText(
                text: "Les plats principaux",
                style: appStyle(13, kGray, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: isLoading
                ? const FoodsListShimmer()
                : ListView(
                    children: List.generate(foods?.length ?? 0, (i) {
                    FoodsModel food = foods![i];
                    return SuiteTile(
                      food: food,
                    );
                  })),
          ),
        ));
  }
}
