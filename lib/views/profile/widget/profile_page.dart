import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/controllers/login_Controller.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/views/auth/login_redirect.dart';
import 'package:glaz/views/auth/widget/verification_page.dart';
import 'package:glaz/views/glaz/glaz_page.dart';
import 'package:glaz/views/glaz/horaires_ouveture.dart';
import 'package:glaz/views/glaz/orchestre_page.dart';
import 'package:glaz/views/order/All_ordres.dart';
import 'package:glaz/views/profile/widget/profile_app_bar.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/views/profile/widget/profile_tile_widget.dart';
import 'package:glaz/views/profile/widget/user_info_widget.dart';
import 'package:glaz/views/reservation/all_reservation.dart';
import 'package:glaz/views/table/fetch_table.dart';

import '../../../common/custom_cantainer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    LoginRespnse? user;
    final box = GetStorage();
    String? token = box.read('token');
    if (token != null) {
      user = controller.getUserInfo(); // Assigne la valeur retournée à user
    }
    if (token == null) {
      return const RedirectPage();
    }
    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kTertiary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h), child: ProfileAppBar()),
      body: SafeArea(
        child: CustomContainer(
            cotainercontent: Column(
          children: [
            UserInfoWidget(user: user),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 202.h,
              decoration: const BoxDecoration(
                color: kLightWhite,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileTilewidget(
                      onTap: () {
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllOrders(),
                            ),
                          );
                        }
                      },
                      title: "Mes ordres",
                      icon: Ionicons.fast_food_outline),
                  ProfileTilewidget(
                      onTap: () {
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllReservation(
                                user: user!, // Utiliser le bang operator
                              ),
                            ),
                          );
                        }
                      },
                      title: "Ma Reservation",
                      icon: Ionicons.restaurant_outline),
                  ProfileTilewidget(
                      onTap: () {
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaTable(
                                user: user!, // Utiliser le bang operator
                              ),
                            ),
                          );
                        }
                      },
                      title: "Ma place Préferée",
                      icon: Ionicons.heart_outline),
                  ProfileTilewidget(
                      onTap: () {},
                      title: "Review",
                      icon: MaterialCommunityIcons.tag_outline)
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 202.h,
              decoration: const BoxDecoration(
                color: kLightWhite,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileTilewidget(
                      onTap: () {
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GlazPage(),
                            ),
                          );
                        }
                      },
                      title: " GLAZ ?",
                      icon: Icons.help_outline),
                  ProfileTilewidget(
                      onTap: () {
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpeningHoursPage(),
                            ),
                          );
                        }
                      },
                      title: "Horaires d'ouverture",
                      icon: Icons.schedule),
                  ProfileTilewidget(
                      onTap: () {
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrchestraPage(),
                            ),
                          );
                        }
                      },
                      title: " GLAZ Orchestres ",
                      icon: Icons.queue_music),
                  ProfileTilewidget(
                      onTap: () {},
                      title: "Paramétres",
                      icon: AntDesign.setting),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onTap: () {
                controller.logout();
              },
              btnColor: kRed,
              text: "Déconnection",
              radius: 0,
            )
          ],
        )),
      ),
    );
  }
}
