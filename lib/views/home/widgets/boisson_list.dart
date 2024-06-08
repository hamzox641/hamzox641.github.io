import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/shimmers/nearby_shimmer.dart';
import 'package:glaz/hooks/fetch_boisson.dart';
import 'package:glaz/models/boisson_model.dart';
import 'package:glaz/views/boisson/boisson_page.dart';
import 'package:glaz/views/home/widgets/boisson_widget.dart';

class BoissonList extends HookWidget {
  const BoissonList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchBoisson("41007428");
    List<BoissonModel>? boissons = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Container(
        height: 184.h,
        child: isLoading
            ? const NearbyShimmer()
            : ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(boissons?.length ?? 0, (i) {
                  BoissonModel boisson = boissons![i];
                  return BoissonWidget(
                    onTap: () {
                      Get.to(() => BoissonPage(boisson: boisson));
                    },
                    image: boisson.imageUrl[0],
                    title: boisson.title,
                    time: boisson.time,
                    price: boisson.price.toStringAsFixed(2),
                    rating: boisson.rating,
                  );
                })));
  }
}
