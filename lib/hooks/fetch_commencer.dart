import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glaz/constants/constants.dart';

import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/dessert_model.dart';
import 'package:glaz/models/commencer_model.dart';

import 'package:glaz/models/hook_models/hook_result.dart';
import "package:http/http.dart" as http;

FetchHook useFetchCommencer(String code) {
  final commencer = useState<List<CommencerModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final appiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/commencer/recommendation/$code');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        commencer.value = commencerModelFromJson(response.body);
      } else {
        appiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    Future.delayed(const Duration(seconds: 3));
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: commencer.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
