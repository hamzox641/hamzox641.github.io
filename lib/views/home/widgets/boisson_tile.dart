import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/boisson_model.dart';
import 'package:glaz/views/boisson/boisson_page.dart';
import 'package:glaz/views/home/rating/rating_dessert_page.dart';

// ignore: must_be_immutable
class BoissonTile extends StatelessWidget {
  const BoissonTile({super.key, this.color, required this.boisson});

  final BoissonModel boisson;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BoissonPage(boisson: boisson));
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 70.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kOffWhite,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 70.w,
                          height: 70.h,
                          child: Image.network(
                            boisson.imageUrl[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 6, bottom: 2.h),
                            color: kGray.withOpacity(0.6),
                            height: 16.h,
                            width: 70.w,
                            child: RatingBarIndicator(
                              rating: boisson.rating,
                              itemCount: 5,
                              itemBuilder: (context, i) => const Icon(
                                Icons.star,
                                color: kSecondary,
                              ),
                              itemSize: 15.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: boisson.title,
                        style: appStyle(11, kDark, FontWeight.w400),
                      ),
                      ReusableText(
                        text: "Temps de préparation : ${boisson.time}",
                        style: appStyle(11, kGray, FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: Column(
              children: [
                Container(
                  width: 60.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: ReusableText(
                      text: "\DH ${boisson.price.toString()}",
                      style: appStyle(12, kOffWhite, FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => RatingDessertPage(productId: boisson.id),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900),
                    );
                  },
                  child: Container(
                    width: 60.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      color: kTertiary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: "Noter",
                        style: appStyle(12, kOffWhite, FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
