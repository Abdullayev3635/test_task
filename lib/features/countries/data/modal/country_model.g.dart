// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      code: json['code'] as String?,
      currency: json['currency'] as String?,
      emoji: json['emoji'] as String?,
      emojiU: json['emojiU'] as String?,
      name: json['name'] as String?,
      native: json['native'] as String?,
      phone: json['phone'] as String?,
      continent: json['continent'] == null
          ? null
          : ContinentModel.fromJson(json['continent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'currency': instance.currency,
      'emoji': instance.emoji,
      'emojiU': instance.emojiU,
      'name': instance.name,
      'native': instance.native,
      'phone': instance.phone,
      'continent': instance.continent,
    };
