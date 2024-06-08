import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/constants/constants.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    required this.cotainercontent,
  });
  Widget cotainercontent;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        child: Container(
          color: color ?? kOffWhite,
          child: SingleChildScrollView(
            child: cotainercontent,
          ),
        ),
      ),
    );
  }
}
