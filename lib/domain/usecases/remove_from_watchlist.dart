import 'package:dartz/dartz.dart';
import 'package:simple_stock_app/domain/repositories/stock_repository.dart';

class RemoveFromWatchlist {
  final StockRepository stockRepository;

  RemoveFromWatchlist(this.stockRepository);

  Future<Either<Exception, String>> execute(int id) =>
      stockRepository.removeFromWatchlist(id);
}
