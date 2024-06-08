import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/common/shimmers/foodlist_shimmer.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/controllers/login_Controller.dart';
import 'package:glaz/hooks/fetch_cart.dart';
import 'package:glaz/models/cart_response.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/views/auth/login_redirect.dart';
import 'package:glaz/views/auth/widget/verification_page.dart';
import 'package:glaz/views/reserver/widget/cart_tile.dart';

import '../../common/custom_cantainer.dart';

class reserverpage extends HookWidget {
  const reserverpage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCart();
    final List<CartResponce> carts = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refrech = hookResult.refetch;

    final apiError = hookResult.error;
    final controller = Get.put(LoginController());
    LoginRespnse? user;
    final box = GetStorage();
    String? token = box.read('token');

    if (token == null) {
      return const RedirectPage();
    }
    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kTertiary,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          title: Center(
            child: ReusableText(
                text: "Mes boissons",
                style: appStyle(14, kTertiary, FontWeight.bold)),
          )),
      body: SafeArea(
        child: CustomContainer(
            cotainercontent: isLoading
                ? const FoodsListShimmer()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: ListView.builder(
                          itemCount: carts.length,
                          itemBuilder: (context, i) {
                            var cart = carts[i];
                            return CartTile(
                                refetch: refrech,
                                color: kLightWhite,
                                cart: cart);
                          }),
                    ),
                  )),
      ),
    );
  }
}
