import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/common/custom_cantainer.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/views/auth/login_page.dart';
import 'package:lottie/lottie.dart';

class RedirectPage extends StatelessWidget {
  const RedirectPage({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      backgroundColor: kTertiary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kTertiary,
        title: Center(
          child: ReusableText(
              text: "Veuillez vous connecter pour accéder à cette page",
              style: appStyle(11, kDark, FontWeight.w500)),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
            cotainercontent: Column(
          children: [
            Container(
              width: width,
              height: height / 2,
              color: Colors.white,
              child: LottieBuilder.asset(
                "assets/anime/cook.json",
                width: width,
                height: height / 2,
              ),
            ),
            CustomButton(
              text: "C O N N E X I O N",
              onTap: () {
                Get.to(() => const LoginPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 900));
              },
              btnHeight: 40.h,
              btnWidth: width - 20,
            )
          ],
        )),
      ),
    );
  }
}
