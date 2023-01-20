import 'package:equatable/equatable.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';

import '../../data/modal/country_model.dart';

class CountryEntity extends Equatable {
  const CountryEntity({
    required this.code,
    required this.currency,
    required this.emoji,
    required this.emojiU,
    required this.name,
    required this.native,
    required this.phone,
    required this.continent,
  });

  final String? code;
  final String? currency;
  final String? emoji;
  final String? emojiU;
  final String? name;
  final String? native;
  final String? phone;
  final ContinentModel? continent;

  @override
  List<Object> get props => [code!];
}