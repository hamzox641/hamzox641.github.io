import 'package:flutter/material.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';

class AllCommencer extends StatelessWidget {
  const AllCommencer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.3,
          backgroundColor: kOffWhite,
          title: ReusableText(
              text: "Pour Commencer",
              style: appStyle(13, kGray, FontWeight.w600))),
      body: const Center(
        child: Text("Pour commencer"),
      ),
    );
  }
}
