import 'package:get/get.dart';

class AdditiveObs extends GetxController {
  final int id;
  final String title;
  final String price;
  RxBool isCheked = false.obs;

  AdditiveObs({
    required this.id,
    required this.title,
    required this.price,
    bool cheked = false,
  }) {
    isCheked.value = cheked;
  }
  void toggleCkecked() {
    isCheked.value = !isCheked.value;
  }
}
