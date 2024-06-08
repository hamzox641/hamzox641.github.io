import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/api_error.dart';

import 'package:glaz/models/categories.dart';
import 'package:glaz/models/hook_models/hook_result.dart';
import "package:http/http.dart" as http;

FetchHook useFetchCategories() {
  final categoriesItem = useState<List<CategoriesModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final appiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/category/random');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        categoriesItem.value = categoriesModelFromJson(response.body);
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
    data: categoriesItem.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
