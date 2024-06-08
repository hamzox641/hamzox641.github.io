import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  bool isOpen() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    // Check if current time is between 12 and 15 or 18 and 1
    if ((hour >= 12 && hour < 15) || (hour >= 18 || hour < 1)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool open = isOpen();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 140.h,
      width: MediaQuery.of(context).size.width,
      color: kTertiary,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: kSecondary,
                    backgroundImage:
                        const AssetImage('assets/images/glaz11.jpg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "GLAZ",
                          style: appStyle(20, kLightWhite, FontWeight.w600),
                        ),
                        ReusableText(
                          text: "23/25, rue Ahmed El Mokri Casablanca",
                          style: appStyle(12, kSecondary, FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              open
                  ? 'assets/icons/open_sign.svg'
                  : 'assets/icons/closed_sign.svg',
              height: 45.h,
              width: 35.w,
            ),
          ],
        ),
      ),
    );
  }
}
