import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/hook_models/hook_result.dart';
import 'package:glaz/models/order_model.dart';
import "package:http/http.dart" as http;

FetchHook useFetchAllOrders() {
  final ordre = useState<List<OrderModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Object?>(null);
  final appiError = useState<ApiError?>(null);
  final box = GetStorage();

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/orders');
      String accessToken = box.read("token");

      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        //debugPrint("JSON Response: $jsonResponse");
        ordre.value = List<OrderModel>.from(
            jsonResponse.map((x) => OrderModel.fromJson(x)));
      } else {
        appiError.value = ApiError.fromJson(json.decode(response.body));
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
    data: ordre.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
