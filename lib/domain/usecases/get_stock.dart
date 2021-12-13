import 'package:dartz/dartz.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/domain/repositories/stock_repository.dart';

class GetStock {
  final StockRepository repository;

  GetStock(this.repository);

  Future<Either<Exception, List<Stock>>> execute() => repository.getStock();
}
