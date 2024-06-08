import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/order_controller.dart';
import 'package:glaz/models/order_model.dart';
import 'package:glaz/views/order/ordre_detailles_screene.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order, this.color, this.refetch});

  final OrderModel order;
  final Color? color;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailsScreen(order: order));
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 70.h,
            decoration: BoxDecoration(
              color: kOffWhite,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < order.orderItems.length; i++)
                    GestureDetector(
                      onTap: () {
                        Get.to(() => OrderDetailsScreen(
                              order: order,
                            ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text:
                                    'Plat : ${order.orderItems[i].foodId?.title ?? order.orderItems[i].dessertId?.title ?? order.orderItems[i].commencerId?.title ?? 'Titre indisponible'}',
                                style: appStyle(11, kDark, FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              ReusableText(
                                text: "Total : ${order.orderTotal} \DH",
                                style: appStyle(11, kTertiary, FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: Container(
              width: 60.w,
              height: 19.h,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: ReusableText(
                  text: "\DH ${order.orderTotal}",
                  style: appStyle(12, kOffWhite, FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: GestureDetector(
              onTap: () {
                controller.removeOrder(order.id);
              },
              child: Row(
                children: [
                  Container(
                    width: 19.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      color: kRed,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Icon(
                        MaterialCommunityIcons.trash_can,
                        size: 15.h,
                        color: kOffWhite,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    width: 60.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 2.w),
                          ReusableText(
                            text: "\DH ${order.orderTotal}",
                            style: appStyle(12, kOffWhite, FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
