import 'package:equatable/equatable.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';

class StockModel extends Equatable {
  final int? id;
  final String description;
  final String symbol;

  const StockModel({
    this.id,
    required this.description,
    required this.symbol,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        description: json['description'],
        symbol: json['symbol'],
      );

  factory StockModel.fromWatchlistJson(Map<String, dynamic> json) => StockModel(
        id: json['id'],
        description: json['description'],
        symbol: json['symbol'],
      );

  factory StockModel.fromEntity(Stock stock) => StockModel(
        description: stock.description,
        symbol: stock.symbol,
      );

  static List<StockModel> createList(List<dynamic> json) =>
      json.map((e) => StockModel.fromJson(e)).toList();

  static List<StockModel> createWatchlist(List<dynamic> json) =>
      json.map((e) => StockModel.fromWatchlistJson(e)).toList();

  Stock get toEntity => Stock(
        description: description,
        symbol: symbol,
      );

  Stock get toWatchlistEntity => Stock(
        id: id,
        description: description,
        symbol: symbol,
      );

  @override
  List<Object?> get props => [description, symbol];
}
