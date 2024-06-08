import 'package:get/get.dart';
import 'package:glaz/models/additives_obs.dart';
import 'package:glaz/models/foods_model.dart';

class FoodController extends GetxController {
  RxInt currentPage = 0.obs;
  bool initialChekValue = false;
  var additivesList = <AdditiveObs>[].obs;
  RxDouble _totalPrice = 0.0.obs;
  double get additivePrice => _totalPrice.value;

  void changePage(int index) {
    currentPage.value = index;
  }

  RxInt count = 1.obs;
  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }

  void loadAdditives(List<Additive> additives) {
    additivesList.clear();
    for (var additivesInfo in additives) {
      var additive = AdditiveObs(
          id: additivesInfo.id,
          title: additivesInfo.title,
          price: additivesInfo.price);
      if (additives.length == additivesList.length) {
      } else {
        additivesList.add(additive);
      }
    }
  }

  List<String> getCarAdditive() {
    List<String> ads = [];
    for (var additive in additivesList) {
      if (additive.isCheked.value && !ads.contains(additive.title)) {
        ads.add(additive.title);
      } else if (!additive.isCheked.value && ads.contains(additive.title)) {
        ads.remove(additive.title);
      }
    }
    return ads;
  }

  set setTotalPrice(double newPrice) {
    _totalPrice.value = newPrice;
  }

  double getTotelPrice() {
    double totalPrice = 0.0;
    for (var additive in additivesList) {
      if (additive.isCheked.value) {
        totalPrice += double.tryParse(additive.price) ?? 0.0;
      }
    }
    setTotalPrice = totalPrice;
    return totalPrice;
  }
}
