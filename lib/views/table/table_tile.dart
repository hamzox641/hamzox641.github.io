import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/models/reservation_response.dart';
import 'package:lottie/lottie.dart';

class TableTile extends StatelessWidget {
  final ReservationResponse reservation;
  final LoginRespnse user;

  const TableTile({Key? key, required this.reservation, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final table = reservation.table;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: 'Nom : ${user.username}',
          style: appStyle(20, kDark, FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        ReusableText(
          text: 'Table Numéro : ${table.tableNumber}',
          style: appStyle(20, kDark, FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        ReusableText(
          text: 'Capacité : ${table.capacity}',
          style: appStyle(16, kTertiary, FontWeight.w400),
        ),
        SizedBox(height: 10.h),
        ReusableText(
          text: 'Position : ${table.position.join(", ")}',
          style: appStyle(16, kTertiary, FontWeight.w400),
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            table.profileImage,
            height: 200.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 320.w,
          height: 300.h,
          child: Lottie.asset("assets/anime/cook.json"),
        ),
      ],
    );
  }
}
