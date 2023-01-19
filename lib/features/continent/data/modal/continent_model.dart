
import '../../domain/entities/continent_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'continent_model.g.dart';

@JsonSerializable()
class ContinentModel {
  final String? code;
  final String? name;

  ContinentModel({this.code, this.name});

  factory ContinentModel.fromJson(Map<String, dynamic> json) => _$ContinentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContinentModelToJson(this);

}
extension ContinentModelX on ContinentModel {
  ContinentEntity toEntity() => ContinentEntity(
    code: code,
    name: name,
  );
}