class DiscoverModel {
  final String markerId;
  final double latitude;
  final double longitude;
  final bool isFull;
  final double? hue;

  DiscoverModel({
    required this.markerId,
    required this.latitude,
    required this.longitude,
    required this.isFull,
    this.hue,
  });

  DiscoverModel copyWith({
    String? markerId,
    double? latitude,
    double? longitude,
    bool? isFull,
    double? hue,
  }) {
    return DiscoverModel(
      markerId: markerId ?? this.markerId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFull: isFull ?? this.isFull,
      hue: hue ?? this.hue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'markerId': markerId,
      'latitude': latitude,
      'longitude': longitude,
      'isFull': isFull,
      'hue': hue,
    };
  }

  factory DiscoverModel.fromMap(Map<String, dynamic> map) {
    return DiscoverModel(
      markerId: map['markerId'] ?? '',
      latitude: map['latitude'] ?? 0,
      longitude: map['longitude'] ?? 0,
      isFull: map['isFull'] ?? false,
      hue: map['hue'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'markerId': markerId,
      'latitude': latitude,
      'longitude': longitude,
      'isFull': isFull,
      'hue': hue,
    };
  }

  factory DiscoverModel.fromJson(Map<String, dynamic> json) {
    return DiscoverModel(
      markerId: json['markerId']?.toString() ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isFull: json['isFull'] == true,
      hue: (json['hue'] as num).toDouble(),
    );
  }

  @override
  bool operator ==(covariant DiscoverModel other) {
    if (identical(this, other)) return true;

    return other.markerId == markerId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isFull == isFull &&
        other.hue == hue;
  }

  @override
  int get hashCode {
    return markerId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        isFull.hashCode ^
        hue.hashCode;
  }

  @override
  String toString() {
    return 'DiscoverModel(markerId: $markerId, lat: $latitude, lng: $longitude)';
  }
}

class DiscoverResponse {
  final List<DiscoverModel> data;

  DiscoverResponse({required this.data});

  factory DiscoverResponse.fromJson(dynamic json) {
    var l = json as List;
    List<DiscoverModel> t = l.map((i) => DiscoverModel.fromJson(i)).toList();
    return DiscoverResponse(data: t);
  }
}
