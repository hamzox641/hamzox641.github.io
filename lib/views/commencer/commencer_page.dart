import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/common/custom_text_feild.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/cart_controller.dart';
import 'package:glaz/controllers/commencer_controller.dart';
import 'package:glaz/controllers/login_Controller.dart';
import 'package:glaz/controllers/order_controller.dart';
import 'package:glaz/models/cart_request.dart';
import 'package:glaz/models/commencer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/models/order_request.dart';
import 'package:glaz/views/auth/login_page.dart';
import 'package:glaz/views/table/table_page.dart';

class CommencerPage extends StatefulWidget {
  const CommencerPage({Key? key, required this.commencer}) : super(key: key);
  final CommencerModel commencer;

  @override
  State<CommencerPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<CommencerPage> {
  final TextEditingController _preferences = TextEditingController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    final cartController = Get.put(CartController());
    LoginRespnse? user;
    final controller = Get.put(CommencerController());
    controller.loadAdditives(widget.commencer.additives);
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
                      itemCount: widget.commencer.imageUrl.length,
                      itemBuilder: (context, i) {
                        return Container(
                          width: width,
                          height: 230.h,
                          color: kTertiary,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.commencer.imageUrl[i],
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
                          widget.commencer.imageUrl.length,
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
                ),
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
                        text: widget.commencer.title,
                        style: appStyle(18, kDark, FontWeight.w600),
                      ),
                      Obx(
                        () => ReusableText(
                          text:
                              "\DH ${((widget.commencer.price + controller.additivePrice) * controller.count.value)}",
                          style: appStyle(18, kPrimary, FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    widget.commencer.description,
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
                        children: List.generate(
                            widget.commencer.foodTags.length, (index) {
                          final tag = widget.commencer.foodTags[index];

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
                    height: 15.h,
                  ),
                  ReusableText(
                      text: "Additivités et Garnitures",
                      style: appStyle(18, kDark, FontWeight.w600)),
                  SizedBox(
                    height: 13.h,
                  ),
                  Obx(
                    () => Column(
                      children: List.generate(controller.additivesList.length,
                          (index) {
                        final additive = controller.additivesList[index];
                        return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            dense: true,
                            activeColor: kSecondary,
                            value: additive.isCheked.value,
                            tristate: false,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableText(
                                    text: additive.title,
                                    style:
                                        appStyle(11, kDark, FontWeight.w400)),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ReusableText(
                                    text: "\DH ${additive.price}",
                                    style: appStyle(
                                        14, kTertiary, FontWeight.w600))
                              ],
                            ),
                            onChanged: (bool? value) {
                              additive.toggleCkecked();
                              controller.getTotelPrice();
                            });
                      }),
                    ),
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
                  ReusableText(
                      text: "Preferences",
                      style: appStyle(18, kDark, FontWeight.w600)),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: CustomTextWidget(
                      controller: _preferences,
                      hintText: "ajouter une note avec votre preferences ",
                      maxLines: 3,
                    ),
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
                        GestureDetector(
                          onTap: () async {
                            if (user == null) {
                              Get.to(() => const LoginPage());
                            } else {
                              double price = (widget.commencer.price +
                                      controller.additivePrice) *
                                  controller.count.value;
                              OrderItem item = OrderItem(
                                  commencerId: widget.commencer.id,
                                  quantity: controller.count.value,
                                  price: price,
                                  additives: controller.getList(),
                                  instructions: _preferences.text);

                              OrderRequest orderRequest = OrderRequest(
                                userId: user.id,
                                orderItems: [item],
                                orderTotal: price,
                                // Ajoutez d'autres informations de commande nécessaires ici
                              );

                              try {
                                await orderController.createOrder(orderRequest);
                                Get.to(
                                  () => TableSelectionPage(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(milliseconds: 900),
                                );
                              } catch (e) {
                                // Handle error (e.g., show a Snackbar with the error message)
                              }
                            }

                            //  showVerificationSheet(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: ReusableText(
                                text: "Passer a choisir la table",
                                style:
                                    appStyle(18, kLightWhite, FontWeight.w600)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            double price = (widget.commencer.price +
                                    controller.additivePrice) *
                                controller.count.value;
                            var data = CartRequest(
                                productId: widget.commencer.id,
                                additives: controller.getList(),
                                quantity: controller.count.value,
                                totalPrice: price);
                            String cart = cartRequestToJson(data);
                            cartController.addToCart(cart);
                          },
                          child: CircleAvatar(
                              backgroundColor: kSecondary,
                              radius: 20.r,
                              child: const Icon(
                                Ionicons.fast_food,
                                color: kTertiary,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /*Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 525.h,
          );
        });
  }*/
}
