import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onTap,
    this.btnWidth,
    this.btnHeight,
    this.btnColor,
    this.radius,
    this.text, // Ajout du texte en paramètre
  }) : super(key: key);

  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnColor;
  final double? radius;
  final String? text; // Ajout du texte

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? 28.h,
        decoration: BoxDecoration(
          color: btnColor ?? kTertiary,
          borderRadius: BorderRadius.circular(radius ?? 9.r),
        ),
        child: Center(
          child: Text(
            text ??
                '', // Utilisation du texte passé en paramètre ou une chaîne vide par défaut
            style: TextStyle(
              color: Colors.white, // Couleur du texte
              fontSize: 16.sp, // Taille du texte
              fontWeight: FontWeight.bold, // Gras
            ),
          ),
        ),
      ),
    );
  }
}
