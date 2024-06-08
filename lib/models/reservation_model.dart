import 'dart:convert';

ReservationModel reservationModelFromJson(String str) =>
    ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) =>
    json.encode(data.toJson());

class ReservationModel {
  final String userId;
  final String tableId;
  final int tableNumber;
  final DateTime reservationTime;
  final int numberOfPersons;

  ReservationModel({
    required this.userId,
    required this.tableId,
    required this.tableNumber,
    required this.reservationTime,
    required this.numberOfPersons,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        userId: json["userId"],
        tableId: json["tableId"],
        tableNumber: json["tableNumber"],
        reservationTime: DateTime.parse(json["reservationTime"]),
        numberOfPersons: json["numberOfPersons"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "tableId": tableId,
        "tableNumber": tableNumber,
        "reservationTime": reservationTime.toIso8601String(),
        "numberOfPersons": numberOfPersons,
      };
}
