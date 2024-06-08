import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';

class OrchestraPage extends StatelessWidget {
  const OrchestraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: " GLAZ Orchestres",
          style: appStyle(20, kWhite, FontWeight.bold),
        ),
        backgroundColor: kTertiary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              const OrchestraTile(
                imagePath: 'assets/images/orchestre1.jpg',
                name: 'Yannick Rieu Génération Quartet',
                musicType: 'Jazz',
              ),
              SizedBox(height: 20.h),
              const OrchestraTile(
                imagePath: 'assets/images/orchestre2.jpg',
                name: 'HBS Moderntet',
                musicType: 'Classical',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrchestraTile extends StatelessWidget {
  final String imagePath;
  final String name;
  final String musicType;

  const OrchestraTile({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.musicType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          name,
          style: appStyle(18, kTertiary, FontWeight.bold),
        ),
        Text(
          musicType,
          style: appStyle(14, kSecondary, FontWeight.w600),
        ),
      ],
    );
  }
}
