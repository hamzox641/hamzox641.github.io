import 'dart:convert';
import 'package:glaz/views/order/itemId.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> orderItems;
  final double orderTotal;
  final int v;

  OrderModel({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.orderTotal,
    required this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"]?.toDouble() ?? 0.0,
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "__v": v,
      };
}

class OrderItem {
  final ItemId? foodId;
  final ItemId? dessertId;
  final ItemId? commencerId;
  final int quantity;
  final double price;
  final List<String> additives;
  final String instructions;
  final String id;

  OrderItem({
    this.foodId,
    this.dessertId,
    this.commencerId,
    required this.quantity,
    required this.price,
    required this.additives,
    required this.instructions,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"] != null ? ItemId.fromJson(json["foodId"]) : null,
        dessertId: json["dessertId"] != null
            ? ItemId.fromJson(json["dessertId"])
            : null,
        commencerId: json["commencerId"] != null
            ? ItemId.fromJson(json["commencerId"])
            : null,
        quantity: json["quantity"],
        price: json["price"]?.toDouble() ?? 0.0,
        additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "quantity": quantity,
      "price": price,
      "additives": List<dynamic>.from(additives.map((x) => x)),
      "instructions": instructions,
      "_id": id,
    };

    if (foodId != null) data["foodId"] = foodId!.toJson();
    if (dessertId != null) data["dessertId"] = dessertId!.toJson();
    if (commencerId != null) data["commencerId"] = commencerId!.toJson();

    return data;
  }
}
