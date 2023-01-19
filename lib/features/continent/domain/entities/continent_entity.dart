import 'package:equatable/equatable.dart';

class ContinentEntity extends Equatable {
  const ContinentEntity({
    required this.code,
    required this.name,
  });

  final String? code;
  final String? name;

  @override
  List<Object> get props => [code!];
}