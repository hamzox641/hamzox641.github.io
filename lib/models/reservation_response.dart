import 'dart:convert';

List<ReservationResponse> reservationResponseFromJson(String str) =>
    List<ReservationResponse>.from(
        json.decode(str).map((x) => ReservationResponse.fromJson(x)));

String reservationResponseToJson(List<ReservationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationResponse {
  final String id;
  final String userId;
  final TableInfo table;
  final DateTime reservationTime;
  final int numberOfPersons;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReservationResponse({
    required this.id,
    required this.userId,
    required this.table,
    required this.reservationTime,
    required this.numberOfPersons,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReservationResponse.fromJson(Map<String, dynamic> json) =>
      ReservationResponse(
        id: json["_id"],
        userId: json["userId"],
        table: TableInfo.fromJson(json["tableId"]),
        reservationTime: DateTime.parse(json["reservationTime"]),
        numberOfPersons: json["numberOfPersons"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "tableId": table.toJson(),
        "reservationTime": reservationTime.toIso8601String(),
        "numberOfPersons": numberOfPersons,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class TableInfo {
  final String id;
  final int tableNumber;
  final int capacity;
  final bool isReserved;
  final dynamic reservationId;
  final List<String> position;
  final String profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  TableInfo({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    required this.isReserved,
    required this.reservationId,
    required this.position,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TableInfo.fromJson(Map<String, dynamic> json) => TableInfo(
        id: json["_id"],
        tableNumber: json["tableNumber"],
        capacity: json["capacity"],
        isReserved: json["isReserved"],
        reservationId: json["reservationId"],
        position: List<String>.from(json["position"].map((x) => x)),
        profileImage: json["profileImage"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tableNumber": tableNumber,
        "capacity": capacity,
        "isReserved": isReserved,
        "reservationId": reservationId,
        "position": List<dynamic>.from(position.map((x) => x)),
        "profileImage": profileImage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
