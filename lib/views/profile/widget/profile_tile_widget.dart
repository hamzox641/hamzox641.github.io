import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';

class ProfileTilewidget extends StatelessWidget {
  const ProfileTilewidget(
      {super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      minLeadingWidth: 0,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: ReusableText(
          text: title, style: appStyle(14, kGray, FontWeight.normal)),
      trailing: title != "Paramétres"
          ? const Icon(
              AntDesign.right,
              size: 16,
            )
          : SvgPicture.asset(
              'assets/icons/morocco.svg',
              width: 15.w,
              height: 15.h,
            ),
    );
  }
}
