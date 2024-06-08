abstract class ItemId {
  String get id;
  String get title;
  double get rating;
  List<String> get imageUrl;
  String get time;

  factory ItemId.fromJson(Map<String, dynamic> json) {
    return _ItemIdImpl.fromJson(json);
  }

  Map<String, dynamic> toJson();
}

class _ItemIdImpl implements ItemId {
  final String id;
  final String title;
  final double rating;
  final List<String> imageUrl;
  final String time;

  _ItemIdImpl({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.time,
  });

  factory _ItemIdImpl.fromJson(Map<String, dynamic> json) => _ItemIdImpl(
        id: json["_id"],
        title: json["title"],
        rating: json["rating"]?.toDouble() ?? 0.0,
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "rating": rating,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
      };
}

class FoodId implements ItemId {
  final String id;
  final String title;
  final double rating;
  final List<String> imageUrl;
  final String time;

  FoodId({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.time,
  });

  factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
        id: json["_id"],
        title: json["title"],
        rating: json["rating"]?.toDouble() ?? 0.0,
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "rating": rating,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
      };
}

class DessertId implements ItemId {
  final String id;
  final String title;
  final double rating;
  final List<String> imageUrl;
  final String time;

  DessertId({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.time,
  });

  factory DessertId.fromJson(Map<String, dynamic> json) => DessertId(
        id: json["_id"],
        title: json["title"],
        rating: json["rating"]?.toDouble() ?? 0.0,
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "rating": rating,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
      };
}

class CommencerId implements ItemId {
  final String id;
  final String title;
  final double rating;
  final List<String> imageUrl;
  final String time;

  CommencerId({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.time,
  });

  factory CommencerId.fromJson(Map<String, dynamic> json) => CommencerId(
        id: json["_id"],
        title: json["title"],
        rating: json["rating"]?.toDouble() ?? 0.0,
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "rating": rating,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
      };
}
