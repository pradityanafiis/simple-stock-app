import 'package:dartz/dartz.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/domain/repositories/stock_repository.dart';

class GetWatchlist {
  final StockRepository stockRepository;

  GetWatchlist(this.stockRepository);

  Future<Either<Exception, List<Stock>>> execute(String uid) =>
      stockRepository.getWatchlist(uid);
}
