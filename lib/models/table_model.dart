import 'dart:convert';

List<TableModel> tableModelFromJson(String str) {
  final jsonData = json.decode(str);
  final List<dynamic> tables = jsonData['tables'];
  return tables.map((table) => TableModel.fromJson(table)).toList();
}

String tableModelToJson(List<TableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  TableModel({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    required this.profileImage,
    required this.position,
  });

  final String id;
  final int tableNumber;
  final int capacity;
  final String profileImage;
  final List<String> position;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["_id"],
        tableNumber: json["tableNumber"],
        capacity: json["capacity"],
        profileImage: json["profileImage"] ?? '',
        position: List<String>.from(json["position"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tableNumber": tableNumber,
        "capacity": capacity,
        "profileImage": profileImage,
        "position": List<dynamic>.from(position.map((x) => x)),
      };
}
