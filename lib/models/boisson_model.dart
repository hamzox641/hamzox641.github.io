import 'dart:convert';

List<BoissonModel> boissonModelFromJson(String str) => List<BoissonModel>.from(
    json.decode(str).map((x) => BoissonModel.fromJson(x)));

String boissonModelToJson(List<BoissonModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoissonModel {
  final String id;
  final String title;
  final String time;
  final String category;
  final List<String> foodType;
  final String code;
  final bool isAvailable;
  final String restaurant;
  final double rating;
  final String ratingCount;
  final String description;
  final double price;
  final List<String> imageUrl;
  final List<String> foodTags;

  BoissonModel({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    required this.foodType,
    required this.code,
    required this.isAvailable,
    required this.restaurant,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.foodTags,
  });

  factory BoissonModel.fromJson(Map<String, dynamic> json) => BoissonModel(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        time: json["time"] ?? '',
        category: json["category"] ?? '',
        foodType: json["foodType"] != null
            ? List<String>.from(json["foodType"].map((x) => x))
            : [],
        code: json["code"] ?? '',
        isAvailable: json["isAvailable"] ?? false,
        restaurant: json["restaurant"] ?? '',
        rating: json["rating"]?.toDouble() ?? 0.0,
        ratingCount: json["ratingCount"] ?? '0',
        description: json["description"] ?? '',
        price: json["price"]?.toDouble() ?? 0.0,
        imageUrl: json["imageUrl"] != null
            ? List<String>.from(json["imageUrl"].map((x) => x))
            : [],
        foodTags: json["foodTags"] != null
            ? List<String>.from(json["foodTags"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "category": category,
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "code": code,
        "isAvailable": isAvailable,
        "restaurant": restaurant,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
      };
}
