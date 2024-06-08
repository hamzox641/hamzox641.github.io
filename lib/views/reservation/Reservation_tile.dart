import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/reservation_controller.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/models/reservation_response.dart';
import 'package:lottie/lottie.dart';

class ReservationTile extends StatelessWidget {
  const ReservationTile({Key? key, required this.reservation, this.user})
      : super(key: key);

  final ReservationResponse reservation;
  final LoginRespnse? user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationController());
    return GestureDetector(
      onTap: () {
        // Ajoutez une action ici si vous souhaitez naviguer vers une page de détails de réservation.
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                height: 120.h, // Ajustez la hauteur si nécessaire
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text:
                                    "Nom : ${user?.username ?? "Username indisponible"}",
                                style: appStyle(20, kDark, FontWeight.bold),
                              ),
                              SizedBox(height: 5.h),
                              ReusableText(
                                text:
                                    'Personnes : ${reservation.numberOfPersons}',
                                style: appStyle(11, kTertiary, FontWeight.w400),
                              ),
                              SizedBox(height: 5.h),
                              ReusableText(
                                text:
                                    'Jour de réservation : ${_formatDate(reservation.reservationTime)}',
                                style: appStyle(11, kTertiary, FontWeight.w400),
                              ),
                              SizedBox(height: 5.h),
                              ReusableText(
                                text:
                                    ' à : ${reservation.reservationTime.hour}:${reservation.reservationTime.minute}',
                                style: appStyle(11, kTertiary, FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 5.w,
                top: 6.h,
                child: GestureDetector(
                  onTap: () {
                    controller.removeReservation(reservation.id);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 19.w,
                        height: 19.h,
                        decoration: BoxDecoration(
                          color: kRed,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Icon(
                            MaterialCommunityIcons.trash_can,
                            size: 15.h,
                            color: kOffWhite,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        width: 60.w,
                        height: 19.h,
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 2.w),
                              ReusableText(
                                text: "G L A Z",
                                style: appStyle(12, kTertiary, FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 320.w,
            height: 400.h,
            child: Lottie.asset("assets/anime/cook.json"),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
