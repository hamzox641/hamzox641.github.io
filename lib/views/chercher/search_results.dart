import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/search_controller.dart';
import 'package:glaz/models/foods_model.dart';
import 'package:glaz/views/home/widgets/suite_tile.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    final controller = Get.put(SearchFoodController());
    return Container(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.h, 0),
        height: height,
        child: ListView.builder(
          itemCount: controller.searchResults!.length,
          itemBuilder: (context, i) {
            FoodsModel food = controller.searchResults![i];
            return SuiteTile(food: food);
          },
        ));
  }
}
