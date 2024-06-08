import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/order_request.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> createOrder(OrderRequest orderRequest) async {
    setLoading = true;
    String accessToken = box.read("token");

    final response = await http.post(
      Uri.parse('$appBaseUrl/api/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(orderRequest.toJson()),
    );

    setLoading = false;

    if (response.statusCode == 201) {
      final orderId = jsonDecode(response.body)['orderId'];
      // Handle successful order creation
      Get.snackbar(
        "Votre Ordre est bien Placer ",
        "Veuillez visiter vos Ordres",
        colorText: kTertiary,
        backgroundColor: kPrimary,
        icon: const Icon(Icons.check_circle_outline, color: kLightWhite),
      );
    } else {
      var error = apiErrorFromJson(response.body);
      Get.snackbar(
        "Error",
        error.message,
        colorText: kRed,
        backgroundColor: kTertiary,
        icon: const Icon(Icons.error_outline, color: kLightWhite),
      );
      throw Exception('Échec de la création de la commande');
    }
  }

  void removeOrder(String orderId) async {
    setLoading = true;
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var url = Uri.parse("$appBaseUrl/api/orders/$orderId");
    try {
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        refresh();
        Get.snackbar(
          "Plat et bien supprimer",
          "",
          colorText: kLightWhite,
          backgroundColor: kTertiary,
          icon: const Icon(Icons.check_circle_outline, color: kLightWhite),
        );
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Error",
          error.message,
          colorText: kRed,
          backgroundColor: kTertiary,
          icon: const Icon(Icons.error_outline, color: kLightWhite),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Une erreur s'est produite lors de la suppression de la commande",
        colorText: kRed,
        backgroundColor: kTertiary,
        icon: const Icon(Icons.error_outline, color: kLightWhite),
      );
    } finally {
      setLoading = false;
      update();
    }
  }
}
