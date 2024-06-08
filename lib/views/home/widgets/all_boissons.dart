import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetche_all_boisson.dart';
import 'package:glaz/models/boisson_model.dart';
import 'package:glaz/views/home/widgets/boisson_tile.dart';

class AllBoissons extends HookWidget {
  const AllBoissons({super.key});

  @override
  Widget build(BuildContext context) {
    final hookresults = useFetchAllBoissons("41007428");
    List<BoissonModel>? boissons = hookresults.data;
    final isLoading = hookresults.isLoading;
    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            backgroundColor: kOffWhite,
            title: ReusableText(
                text: "Boissons de GLAZ",
                style: appStyle(13, kGray, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: isLoading
                ? const FoodsListShimmer()
                : ListView(
                    children: List.generate(boissons?.length ?? 0, (i) {
                    BoissonModel boisson = boissons![i];
                    return BoissonTile(
                      boisson: boisson,
                    );
                  })),
          ),
        ));
  }
}
