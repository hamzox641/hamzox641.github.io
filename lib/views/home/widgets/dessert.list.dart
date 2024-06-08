import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/shimmers/nearby_shimmer.dart';
import 'package:glaz/hooks/fetch_dessert.dart';
import 'package:glaz/models/dessert_model.dart';
import 'package:glaz/views/dessert/dessert_page.dart';
import 'package:glaz/views/home/widgets/dessert_widget.dart';

class DessertList extends HookWidget {
  const DessertList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchDessert("41007428");
    List<DessertModel>? desserts = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Container(
        height: 184.h,
        child: isLoading
            ? const NearbyShimmer()
            : ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(desserts?.length ?? 0, (i) {
                  DessertModel dessert = desserts![i];
                  return DessertWidget(
                    onTap: () {
                      Get.to(() => DessertPage(dessert: dessert));
                    },
                    image: dessert.imageUrl[0],
                    title: dessert.title,
                    time: dessert.time,
                    price: dessert.price.toStringAsFixed(2),
                    rating: dessert.rating,
                  );
                })));
  }
}
