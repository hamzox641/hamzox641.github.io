import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:glaz/controllers/tab_index_controller.dart';
import 'package:glaz/views/chercher/chercher_page.dart';
import 'package:glaz/views/home/home_page.dart';
import 'package:glaz/views/profile/widget/profile_page.dart';
import 'package:glaz/views/reserver/bonssons_page.dart';

import '../constants/constants.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    ChercherPage(),
    reserverpage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pageList[controller.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: kTertiary),
                    child: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.black38),
                      selectedIconTheme: IconThemeData(color: kPrimaryLight),
                      onTap: (value) {
                        controller.setTabIndex = value;
                      },
                      currentIndex: controller.tabIndex,
                      items: [
                        BottomNavigationBarItem(
                            icon: controller.tabIndex == 0
                                ? Icon(AntDesign.appstore1)
                                : Icon(AntDesign.appstore_o),
                            label: 'GLAZ'),
                        const BottomNavigationBarItem(
                            icon: Icon(Icons.search), label: 'chercher'),
                        const BottomNavigationBarItem(
                            icon: Badge(
                                label: Text('1'),
                                child: Icon(Icons.local_drink)),
                            label: 'boissons'),
                        BottomNavigationBarItem(
                            icon: controller.tabIndex == 3
                                ? const Icon(FontAwesome.user_circle)
                                : const Icon(FontAwesome.user_circle_o),
                            label: 'profile'),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
