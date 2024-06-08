import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glaz/constants/constants.dart';

import 'package:glaz/models/api_error.dart';

import 'package:glaz/models/hook_models/hook_result.dart';
import 'package:glaz/models/restaurant_model.dart';
import "package:http/http.dart" as http;

FetchHook useFetchAllRestaurants(String code) {
  final restaurants = useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final appiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/all/$code');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        restaurants.value = restaurantModelFromJson(response.body);
      } else {
        appiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      // Capturer l'exception et la stocker dans 'error'
      error.value = e as Exception;
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
    data: restaurants.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
