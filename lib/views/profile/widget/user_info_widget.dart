import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/login_response.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, this.user});
  final LoginRespnse? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      color: kOffWhite,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30.w,
                  backgroundColor: kGrayLight,
                  backgroundImage: NetworkImage(user!
                      .profile) // Remplacez 'path_to_your_image' par le chemin de votre image
                  ),
              SizedBox(width: 6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                      text: user!.username ?? "Username",
                      style: appStyle(20, kDark, FontWeight.bold)),
                  SizedBox(height: 1.h),
                  ReusableText(
                      text: user!.email ?? "hamzanadif",
                      style: appStyle(12, kTertiary, FontWeight.normal))
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Ajoutez ici la logique pour modifier les informations
            },
          ),
        ],
      ),
    );
  }
}
