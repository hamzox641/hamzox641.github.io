import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/custom_appbar.dart';
import 'package:glaz/common/custom_cantainer.dart';
import 'package:glaz/common/heading.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/category_controler.dart';
import 'package:glaz/views/home/all_commencer.dart';
import 'package:glaz/views/home/widgets/all_boissons.dart';
import 'package:glaz/views/home/widgets/boisson_list.dart';
import 'package:glaz/views/home/widgets/commencer_liste.dart';
import 'package:glaz/views/home/widgets/dessert.list.dart';
import 'package:glaz/views/home/widgets/plats_list.dart';

import 'all_desserts.dart';
import 'suite_plats.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Scaffold(
      backgroundColor: kTertiary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h), child: const CustomAppbar()),
      body: SafeArea(
        child: CustomContainer(
            cotainercontent: Column(children: [
          // const CategoryList(),
          Obx(
            () => controller.categoryValue == ''
                ? Column(
                    children: [
                      /* Heading(
                        text: "Nos meilleurs plats",
                        onTap: () {
                         Get.to(() => const PlatPourCommencer(),
                             transition: Transition.cupertino,
                              duration: const Duration(microseconds: 900));
                        },
                      ),*/
                      // PourCommencerListe(),
                      Heading(
                        text: "Pour commencer",
                        onTap: () {
                          Get.to(() => const AllCommencer(),
                              transition: Transition.cupertino,
                              duration: const Duration(microseconds: 900));
                        },
                      ),
                      const CommencerList(),
                      Heading(
                        text: "La Suite",
                        onTap: () {
                          Get.to(() => const PlatsSuite(),
                              transition: Transition.cupertino,
                              duration: const Duration(microseconds: 900));
                        },
                      ),
                      const PlatList(),
                      Heading(
                        text: "Dessert",
                        onTap: () {
                          Get.to(() => const AllDesserts(),
                              transition: Transition.cupertino,
                              duration: const Duration(microseconds: 900));
                        },
                      ),
                      const DessertList(),
                      Heading(
                        text: "GLAZ Boissons",
                        onTap: () {
                          Get.to(() => const AllBoissons(),
                              transition: Transition.cupertino,
                              duration: const Duration(microseconds: 900));
                        },
                      ),
                      const BoissonList(),
                    ],
                  )
                : CustomContainer(cotainercontent: Column()),
          )
        ])),
      ),
    );
  }
}
