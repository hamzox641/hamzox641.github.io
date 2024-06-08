import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/reservation_model.dart';
import 'package:http/http.dart' as http;

class ReservationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> createReservation(ReservationModel reservation) async {
    setLoading = true;
    String accessToken = box.read("token");

    final response = await http.post(
      Uri.parse('$appBaseUrl/api/reservation'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(reservation.toJson()),
    );

    setLoading = false;

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      Get.snackbar(
        "Réservation réussie",
        responseData['message'],
        colorText: kTertiary,
        backgroundColor: kPrimary,
        icon: const Icon(Icons.check_circle_outline, color: kLightWhite),
      );
    } else {
      var error = apiErrorFromJson(response.body);
      Get.snackbar(
        "Erreur",
        error.message,
        colorText: kRed,
        backgroundColor: kTertiary,
        icon: const Icon(Icons.error_outline, color: kLightWhite),
      );
      throw Exception('Échec de la création de la réservation');
    }
  }

  void removeReservation(String reservationId) async {
    setLoading = true;
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var url =
        Uri.parse("$appBaseUrl/api/reservation/reservations/$reservationId");
    try {
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        refresh();
        Get.snackbar(
          "Réservation supprimée",
          "",
          colorText: kLightWhite,
          backgroundColor: kTertiary,
          icon: const Icon(Icons.check_circle_outline, color: kLightWhite),
        );
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Erreur",
          error.message,
          colorText: kRed,
          backgroundColor: kTertiary,
          icon: const Icon(Icons.error_outline, color: kLightWhite),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Erreur",
        "Une erreur s'est produite lors de la suppression de la réservation",
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
