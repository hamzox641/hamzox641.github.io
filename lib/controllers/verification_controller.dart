import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/views/entrypoint.dart';
import 'package:http/http.dart' as http;

class VerificationController extends GetxController {
  final box = GetStorage();
  String _code = "";
  String get code => _code;
  set setCode(String value) {
    _code = value;
  }

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool value) {
    _isLoading.value = value;
  }

  void verificationFunction() async {
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    setLoading = true;
    Uri url = Uri.parse('$appBaseUrl/api/users/verify/$code');

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = loginRespnseFromJson(response.body);
        String userId = data.id;
        String userData = jsonEncode(data);
        box.write(userId, userData);
        box.write("token", data.userToken);
        box.write("userId", data.id);
        box.write("verification", data.verification);

        setLoading = false;
        Get.snackbar("vous etes verifier", "enjoy your awesome experience",
            colorText: kLightWhite,
            backgroundColor: kTertiary,
            icon: const Icon(Ionicons.fast_food_outline));
        Get.offAll(() => MainScreen());
        if (data.verification == true) {
          Get.offAll(() => MainScreen(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 900));
        }
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Failed to verify", error.message,
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
