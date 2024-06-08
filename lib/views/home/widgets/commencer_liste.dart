import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/shimmers/nearby_shimmer.dart';
import 'package:glaz/hooks/fetch_commencer.dart';
import 'package:glaz/models/commencer_model.dart';
import 'package:glaz/views/commencer/commencer_page.dart';
import 'package:glaz/views/home/widgets/commencer_widget.dart';

class CommencerList extends HookWidget {
  const CommencerList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchCommencer("41007428");
    List<CommencerModel>? commencers = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Container(
        height: 184.h,
        child: isLoading
            ? const NearbyShimmer()
            : ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(commencers?.length ?? 0, (i) {
                  CommencerModel commencer = commencers![i];
                  return CommencerWidget(
                    onTap: () {
                      Get.to(() => CommencerPage(commencer: commencer));
                    },
                    image: commencer.imageUrl[0],
                    title: commencer.title,
                    time: commencer.time,
                    price: commencer.price.toStringAsFixed(2),
                    rating: commencer.rating,
                  );
                })));
  }
}
