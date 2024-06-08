import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/table_model.dart';
import 'package:glaz/views/table/reservation_page.dart';
import 'package:lottie/lottie.dart';

class TableDetailPage extends StatelessWidget {
  final TableModel table;

  TableDetailPage({required this.table});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTertiary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kTertiary,
        title: Center(
          child: ReusableText(
            text: 'Détails de la Table',
            style: appStyle(18, kLightWhite, FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  table.profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Table ${table.tableNumber}',
                style: appStyle(24, kGrayLight, FontWeight.bold)),
            SizedBox(height: 10),
            Text('Capacité: ${table.capacity}',
                style: appStyle(18, kDark, FontWeight.w400)),
            SizedBox(height: 10),
            Text('Position: ${table.position.join(', ')}',
                style: appStyle(18, kDark, FontWeight.w400)),
            SizedBox(height: 20),
            CustomButton(
              text: 'Sélectionner cette table',
              btnHeight: 45,
              onTap: () {
                Get.to(() => ReservationPage(
                      table: table,
                    ));
              },
            ),
            SizedBox(
              width: 320.w,
              height: 180.h,
              child: Lottie.asset("assets/anime/cook.json"),
            ),
          ],
        ),
      ),
    );
  }
}
