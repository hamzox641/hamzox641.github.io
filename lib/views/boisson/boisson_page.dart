import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/boisson_controller.dart';
import 'package:glaz/controllers/cart_controller.dart';
import 'package:glaz/models/boisson_model.dart';
import 'package:glaz/models/cart_request.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:glaz/models/login_response.dart';

import '../../controllers/login_Controller.dart';

class BoissonPage extends StatefulWidget {
  const BoissonPage({Key? key, required this.boisson}) : super(key: key);
  final BoissonModel boisson;

  @override
  State<BoissonPage> createState() => _BoissonPageState();
}

class _BoissonPageState extends State<BoissonPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    LoginRespnse? user;
    final controller = Get.put(BoissonController());
    final loginController = Get.put(LoginController());
    user = loginController.getUserInfo();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.r),
                  ),
                  child: SizedBox(
                    height: 230.h,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) {
                        controller.changePage(i);
                      },
                      itemCount: widget.boisson.imageUrl.length,
                      itemBuilder: (context, i) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 230.h,
                          color: kTertiary,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.boisson.imageUrl[i],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.boisson.imageUrl.length,
                          (index) {
                            return Container(
                              margin: EdgeInsets.only(left: 12.0),
                              width: 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.currentPage == index
                                    ? kTertiary
                                    : kGray,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 12.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Ionicons.chevron_back_circle,
                      color: kTertiary,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 12.w,
                  child: CustomButton(btnWidth: 90.w, text: "G L A Z"),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: widget.boisson.title,
                        style: appStyle(18, kDark, FontWeight.w600),
                      ),
                      Obx(
                        () => ReusableText(
                          text:
                              "\DH ${(widget.boisson.price * controller.count.value)}",
                          style: appStyle(18, kPrimary, FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    widget.boisson.description,
                    textAlign: TextAlign.justify,
                    maxLines: 8,
                    style: appStyle(12, kTertiary, FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 15.h,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(widget.boisson.foodTags.length,
                            (index) {
                          final tag = widget.boisson.foodTags[index];

                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                                color: kPrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.r))),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: ReusableText(
                                  text: tag,
                                  style: appStyle(11, kWhite, FontWeight.w300),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                          text: "Quantité",
                          style: appStyle(18, kDark, FontWeight.w600)),
                      SizedBox(
                        width: 5.w,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.increment();
                            },
                            child: const Icon(AntDesign.pluscircleo),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () => ReusableText(
                                    text: "${controller.count.value}",
                                    style:
                                        appStyle(14, kDark, FontWeight.w600)),
                              )),
                          GestureDetector(
                            onTap: () {
                              controller.decrement();
                            },
                            child: const Icon(AntDesign.minuscircleo),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: kTertiary,
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ReusableText(
                            text: "Prend ce boisson",
                            style: appStyle(18, kLightWhite, FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Journaliser les valeurs avant l'appel
                            print("Count before: ${controller.count.value}");
                            print("Price before: ${widget.boisson.price}");

                            double price =
                                widget.boisson.price * controller.count.value;
                            var data = CartRequest(
                                productId: widget.boisson.id,
                                additives: [], // Pas d'additives
                                quantity: controller.count.value,
                                totalPrice: price);
                            String cart = cartRequestToJson(data);

                            cartController.addToCart(
                                cart); // Attendre que l'ajout au panier soit terminé

                            // Journaliser les valeurs après l'appel
                            print("Count after: ${controller.count.value}");
                            print("Price after: ${widget.boisson.price}");

                            setState(() {}); // Mettre à jour l'UI après l'ajout
                          },
                          child: CircleAvatar(
                            backgroundColor: kSecondary,
                            radius: 20.r,
                            child: const Icon(
                              Ionicons.fast_food,
                              color: kTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
