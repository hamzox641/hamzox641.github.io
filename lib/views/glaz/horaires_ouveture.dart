import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:lottie/lottie.dart';

class OpeningHoursPage extends StatelessWidget {
  const OpeningHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: "Heures d'ouverture",
          style: appStyle(20, kWhite, FontWeight.bold),
        ),
        backgroundColor: kTertiary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/glaz9.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "G  L  A  Z",
                  style: appStyle(24, kTertiary, FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 320.w,
                height: 300.h,
                child: Lottie.asset("assets/anime/cook.json"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
