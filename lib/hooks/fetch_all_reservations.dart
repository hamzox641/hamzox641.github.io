import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/hook_models/hook_result.dart';
import 'package:glaz/models/reservation_response.dart';
import "package:http/http.dart" as http;

FetchHook useFetchLastReservation() {
  final reservation = useState<ReservationResponse?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Object?>(null);
  final apiError = useState<ApiError?>(null);
  final box = GetStorage();

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      String userId = box.read(
          "userId"); // Assurez-vous que l'ID de l'utilisateur est stocké dans GetStorage
      Uri url = Uri.parse(
          '$appBaseUrl/api/reservation/$userId'); // Mettez à jour l'URL pour cibler la dernière réservation
      String accessToken = box.read("token");

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        reservation.value = ReservationResponse.fromJson(jsonResponse);
      } else {
        apiError.value = ApiError.fromJson(json.decode(response.body));
      }
    } catch (e) {
      error.value = e;
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: reservation.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
