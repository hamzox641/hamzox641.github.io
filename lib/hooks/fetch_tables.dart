import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/table_model.dart';
import 'package:http/http.dart' as http;

class FetchHook<T> {
  final T? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback refetch;

  FetchHook({
    required this.data,
    required this.error,
    required this.isLoading,
    required this.refetch,
  });
}

FetchHook<List<TableModel>> useFetchTables() {
  final table = useState<List<TableModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/table');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Add logging for debugging
        // print('API Response: ${response.body}');
        table.value = tableModelFromJson(response.body);
      } else {
        // print('API Error: ${response.body}');
        error.value = Exception('Failed to load tables');
      }
    } catch (e) {
      //  print('Exception: $e');
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

  return FetchHook<List<TableModel>>(
    data: table.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
