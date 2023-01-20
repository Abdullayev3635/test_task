import 'package:json_annotation/json_annotation.dart';

import '../../../continent/data/modal/continent_model.dart';
import '../../domain/entities/country_entity.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  String? code;
  String? currency;
  String? emoji;
  String? emojiU;
  String? name;
  String? native;
  String? phone;
  ContinentModel? continent;

  CountryModel(
      {this.code,
      this.currency,
      this.emoji,
      this.emojiU,
      this.name,
      this.native,
      this.phone,
      this.continent});

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

extension CountryModelX on CountryModel {
  CountryEntity toEntity() => CountryEntity(
      code: code,
      currency: currency,
      emoji: emoji,
      emojiU: emojiU,
      name: name,
      native: native,
      continent: continent,
      phone: phone);
}
