import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_all_reservations.dart';
import 'package:glaz/models/reservation_response.dart';
import 'package:glaz/models/login_response.dart'; // Ajouter cet import
import 'package:glaz/views/reservation/Reservation_tile.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class AllReservation extends HookWidget {
  final LoginRespnse user; // Ajouter cet argument

  const AllReservation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchLastReservation();
    ReservationResponse? reservation = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
        appBar: AppBar(
            elevation: 0.3,
            backgroundColor: kOffWhite,
            title: ReusableText(
                text: "Ma Reservation",
                style: appStyle(13, kGray, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: isLoading
                ? const FoodsListShimmer()
                : reservation != null
                    ? ReservationTile(
                        reservation: reservation,
                        user: user,
                      )
                    : Center(
                        child: Text(
                          'Aucune réservation trouvée',
                          style: appStyle(16, kGray, FontWeight.w600),
                        ),
                      ),
          ),
        ));
  }
}
