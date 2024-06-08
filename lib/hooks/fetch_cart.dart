import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glaz/constants/constants.dart';

import 'package:glaz/models/api_error.dart';
import 'package:glaz/models/cart_response.dart';

import 'package:glaz/models/hook_models/hook_result.dart';
import "package:http/http.dart" as http;

FetchHook useFetchCart() {
  final box = GetStorage();
  final cart = useState<List<CartResponce>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final appiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/cart');

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        cart.value = cartResponceFromJson(response.body);
      } else {
        appiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
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
    data: cart.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
