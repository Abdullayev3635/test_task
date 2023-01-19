import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  const CountryEntity({
    required this.code,
    required this.currency,
    required this.emoji,
    required this.emojiU,
    required this.name,
    required this.native,
    required this.phone,
  });

  final String? code;
  final String? currency;
  final String? emoji;
  final String? emojiU;
  final String? name;
  final String? native;
  final String? phone;

  @override
  List<Object> get props => [code!];
}