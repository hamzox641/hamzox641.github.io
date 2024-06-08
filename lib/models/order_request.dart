import 'dart:convert';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
  final String userId;
  final List<OrderItem> orderItems;
  final double orderTotal;

  OrderRequest({
    required this.userId,
    required this.orderItems,
    required this.orderTotal,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal:
            json["orderTotal"]?.toDouble() ?? 0.0, // Default to 0.0 if null
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
      };
}

class OrderItem {
  final String? foodId;
  final String? dessertId;
  final String? commencerId;
  final int quantity;
  final double price;
  final List<String> additives;
  final String instructions;

  OrderItem({
    this.foodId,
    this.dessertId,
    this.commencerId,
    required this.quantity,
    required this.price,
    required this.additives,
    required this.instructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"],
        dessertId: json["dessertId"],
        commencerId: json["commencerId"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble() ?? 0.0, // Default to 0.0 if null
        additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "quantity": quantity,
      "price": price,
      "additives": List<dynamic>.from(additives.map((x) => x)),
      "instructions": instructions,
    };

    if (foodId != null) data["foodId"] = foodId;
    if (dessertId != null) data["dessertId"] = dessertId;
    if (commencerId != null) data["commencerId"] = commencerId;

    return data;
  }
}
