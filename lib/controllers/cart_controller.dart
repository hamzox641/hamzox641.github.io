import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool value) {
    _isLoading.value = value;
  }

  void addToCart(String cart) async {
    setLoading = true;
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var url = Uri.parse("$appBaseUrl/api/cart");
    try {
      var response = await http.post(url, headers: headers, body: cart);
      if (response.statusCode == 200) {
        setLoading = false;
        Get.snackbar(" est ajouter a la reservation", "Apprecier",
            colorText: kLightWhite,
            backgroundColor: kTertiary,
            icon: const Icon(
              Icons.check_circle_outline,
              color: kLightWhite,
            ));
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(" erreur", "Apprecier",
            colorText: kRed,
            backgroundColor: kTertiary,
            icon: const Icon(
              Icons.check_circle_outline,
              color: kLightWhite,
            ));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
  }

  void removeFromCart(String productId, Function refetch) async {
    setLoading = true;
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var url = Uri.parse("$appBaseUrl/api/cart/$productId");
    try {
      var response = await http.delete(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        setLoading = false;
        refresh();
        Get.snackbar(" produit est supprimer", "Apprecier",
            colorText: kLightWhite,
            backgroundColor: kTertiary,
            icon: const Icon(
              Icons.check_circle_outline,
              color: kLightWhite,
            ));
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(" erreur", "Apprecier",
            colorText: kRed,
            backgroundColor: kTertiary,
            icon: const Icon(
              Icons.check_circle_outline,
              color: kLightWhite,
            ));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
      update();
    }
  }
}
