import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_all_orders.dart';
import 'package:glaz/models/order_model.dart';
import 'package:glaz/views/order/order_tile.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class AllOrders extends HookWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllOrders();
    List<OrderModel>? orders = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            backgroundColor: kOffWhite,
            title: ReusableText(
                text: "Mes commandes",
                style: appStyle(13, kGray, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: isLoading
                ? const FoodsListShimmer()
                : ListView(
                    children: List.generate(orders?.length ?? 0, (i) {
                    OrderModel order = orders![i];
                    return OrderTile(
                      order: order,
                    );
                  })),
          ),
        ));
  }
}
