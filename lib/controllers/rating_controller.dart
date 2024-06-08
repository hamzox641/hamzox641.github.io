import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RatingController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> postRating(RatingModel rating) async {
    setLoading = true;
    String accessToken = box.read("token");

    final response = await http.post(
      Uri.parse('$appBaseUrl/api/rating'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(rating.toJson()),
    );

    setLoading = false;

    // Debug: Print the status code and response body
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      // Custom message instead of responseData['message']
      String customMessage = "Votre cotation a bien été prise en compte.";
      // Ensure you are using the correct context for the Snackbar
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          "Notation réussie",
          customMessage,
          colorText: kTertiary,
          backgroundColor: kPrimary,
          icon: const Icon(Icons.check_circle_outline, color: kLightWhite),
        );
      });
    } else {
      var error = apiErrorFromJson(response.body);
      print(response.statusCode); // Debug: Print status code if not 200
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          "Erreur",
          error.message,
          colorText: kRed,
          backgroundColor: kTertiary,
          icon: const Icon(Icons.error_outline, color: kLightWhite),
        );
      });
      throw Exception('Échec de la soumission de la notation');
    }
  }
}

class RatingModel {
  final String ratingType;
  final String product;
  final int rating;

  RatingModel({
    required this.ratingType,
    required this.product,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        'ratingType': ratingType,
        'product': product,
        'rating': rating,
      };
}

apiErrorFromJson(String str) {
  final jsonData = json.decode(str);
  return ApiError.fromJson(jsonData);
}

class ApiError {
  final String message;

  ApiError({required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        message: json["message"],
      );
}
