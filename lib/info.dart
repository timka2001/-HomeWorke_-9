import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  String? uuid;
  String? name;
  String? poster;
  Address? address;
  double? rating;
  Services? services;
  List<String>? photos;

  Info(
      {this.uuid,
      this.name,
      this.poster,
      this.address,
      this.rating,
      this.services,
      this.photos});
  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Address {
  String? country;
  String? street;
  String? city;

  Address({this.country, this.street, this.city});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Services {
  List<String>? free;
  List<String>? paid;

  Services({this.free, this.paid});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
