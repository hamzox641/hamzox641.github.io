import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/back_ground_container.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_all_reservations.dart';
import 'package:glaz/models/reservation_response.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/views/table/table_tile.dart';

class MaTable extends HookWidget {
  final LoginRespnse user;

  const MaTable({super.key, required this.user});

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
          text: "Ma table",
          style: appStyle(13, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: isLoading
              ? const FoodsListShimmer()
              : reservation != null
                  ? TableTile(
                      reservation: reservation,
                      user: user,
                    )
                  : Center(
                      child: Text(
                        'Aucune table trouvée',
                        style: appStyle(16, kGray, FontWeight.w600),
                      ),
                    ),
        ),
      ),
    );
  }
}
