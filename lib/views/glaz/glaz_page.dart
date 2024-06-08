import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';

class GlazPage extends StatelessWidget {
  const GlazPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: "G L A Z",
          style: appStyle(20, kWhite, FontWeight.bold),
        ),
        backgroundColor: kTertiary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/glaz4.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/glaz6.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/glaz7.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/glaz8.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "Bienvenue au Glaz, où les couleurs de la Bretagne s'expriment dans toute leur splendeur 🌊!\n\n"
                "Glaz, c'est bien plus qu'un simple mot. C'est un voyage au cœur des teintes enchanteresses de la mer bretonne, du turquoise éclatant des rivages aux profondeurs azurées de l'océan. "
                "Mais c'est aussi la représentation vivante de la nature, des feuilles verdoyantes aux herbes aromatiques, symboles de vie et de fraîcheur 💙.",
                style: appStyle(16, kTertiary, FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
