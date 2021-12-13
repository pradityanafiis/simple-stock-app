import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final int? id;
  final String description;
  final String symbol;

  const Stock({
    this.id,
    required this.description,
    required this.symbol,
  });

  String get symbolToDisplay => symbol.substring(0, symbol.indexOf('.'));

  @override
  List<Object?> get props => [description, symbol];
}
