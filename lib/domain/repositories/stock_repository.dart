import 'package:dartz/dartz.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';

abstract class StockRepository {
  Future<Either<Exception, List<Stock>>> getStock();
  Future<Either<Exception, Stock>> addToWatchlist(Stock stock, String uid);
  Future<Either<Exception, List<Stock>>> getWatchlist(String uid);
  Future<Either<Exception, String>> removeFromWatchlist(int id);
}
