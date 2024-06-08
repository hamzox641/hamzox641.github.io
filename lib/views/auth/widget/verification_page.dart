import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/common/custom_cantainer.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/verification_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    return Scaffold(
      // backgroundColor: kPrimary,
      appBar: AppBar(
        title: ReusableText(
            text: "s il vous plait verifier votre compte",
            style: appStyle(12, kGray, FontWeight.w600)),
        centerTitle: true,
        backgroundColor: kOffWhite,
        elevation: 0,
      ),
      body: CustomContainer(
          cotainercontent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
            height: height,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Lottie.asset("assets/anime/cook.json"),
                ReusableText(
                    text: " verifier votre compte",
                    style: appStyle(20, kTertiary, FontWeight.w600)),
                SizedBox(height: 5.h),
                Text(
                    "Entrer le code envoyer a votre email,si vous ne voyez pas le code veuillez verifier votre dossier spam",
                    textAlign: TextAlign.justify,
                    style: appStyle(12, kGray, FontWeight.normal)),
                SizedBox(height: 20.h),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: kTertiary,
                  borderWidth: 2.0,
                  textStyle: appStyle(17, kDark, FontWeight.w600),
                  onCodeChanged: (String code) {},
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onSubmit: (String verificationCode) {
                    controller.setCode = verificationCode;
                  },
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: "V E R I F I E R    C O M P T E ",
                  onTap: () {
                    controller.verificationFunction();
                  },
                  btnHeight: 35.h,
                  btnWidth: width,
                ),
              ],
            )),
      )),
    );
  }
}
