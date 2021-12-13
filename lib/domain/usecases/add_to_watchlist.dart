import 'package:dartz/dartz.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/domain/repositories/stock_repository.dart';

class AddToWatchlist {
  final StockRepository stockRepository;

  AddToWatchlist(this.stockRepository);

  Future<Either<Exception, Stock>> execute(Stock stock, String uid) =>
      stockRepository.addToWatchlist(stock, uid);
}
