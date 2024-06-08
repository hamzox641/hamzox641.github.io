import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glaz/constants/constants.dart';

import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/boisson_model.dart';

import 'package:glaz/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchAllBoissons(String code) {
  final boissons = useState<List<BoissonModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/boisson/byCode/$code');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        boissons.value = boissonModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
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
    data: boissons.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
