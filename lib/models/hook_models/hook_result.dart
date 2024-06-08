import 'package:flutter/material.dart';

class FetchHook {
  final dynamic data;
  final bool isLoading;
  final Object? error;
  final VoidCallback? refetch;

  FetchHook({
    required this.data,
    required this.error,
    required this.isLoading,
    required this.refetch,
  });
}
