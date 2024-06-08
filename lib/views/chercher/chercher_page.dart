// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:glaz/common/custom_cantainer.dart';
import 'package:glaz/common/custom_text_feild.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/search_controller.dart';
import 'package:glaz/views/chercher/loading_widget.dart';
import 'package:glaz/views/chercher/search_results.dart';

class ChercherPage extends StatefulWidget {
  const ChercherPage({super.key});

  @override
  State<ChercherPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<ChercherPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());
    return Obx(() => Scaffold(
          backgroundColor: kTertiary,
          appBar: AppBar(
            toolbarHeight: 100.h,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: CustomTextWidget(
                controller: _searchController,
                keyboardType: TextInputType.text,
                hintText: "chercher  plats",
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (controller.isTriggered == false) {
                      controller.searchFoods(_searchController.text);
                      controller.setTrigger = true;
                    } else {
                      controller.searchResults = null;
                      controller.setTrigger = false;
                      _searchController.clear();
                    }
                  },
                  child: controller.isTriggered == false
                      ? Icon(
                          Ionicons.search_circle,
                          size: 40,
                          color: kTertiary,
                        )
                      : Icon(
                          Ionicons.close_circle,
                          size: 40,
                          color: kRed,
                        ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: CustomContainer(
              cotainercontent: controller.isLoading
                  ? const FoodsListShimmer()
                  : controller.searchResults == null
                      ? const LoadingWidget()
                      : SearchResults(),
            ),
          ),
        ));
  }
}
