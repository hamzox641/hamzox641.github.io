import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/success_model.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  void registrationFunction(String data) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    setLoading = true;
    Uri url = Uri.parse('$appBaseUrl/register');

    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.statusCode);
      if (response.statusCode == 201) {
        var data = successModelFromJson(response.body);

        setLoading = false;
        Get.back();
        Get.snackbar("Vous etes inscrit avec succés ", data.message,
            colorText: kLightWhite,
            backgroundColor: kTertiary,
            icon: const Icon(Ionicons.fast_food_outline));
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Echec de l inscription", error.message,
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
