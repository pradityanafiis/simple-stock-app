import 'package:simple_stock_app/data/datasources/stock_remote_data_source.dart';
import 'package:simple_stock_app/data/models/stock_model.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_stock_app/domain/repositories/stock_repository.dart';

class StockRepositoryImpl extends StockRepository {
  final StockRemoteDataSource remoteDataSource;

  StockRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, List<Stock>>> getStock() async {
    try {
      final _result = await remoteDataSource.getStock();
      return Right(_result.map((e) => e.toEntity).toList());
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, Stock>> addToWatchlist(
      Stock stock, String uid) async {
    try {
      final _result = await remoteDataSource.addToWatchlist(
          StockModel.fromEntity(stock), uid);
      return Right(_result.toEntity);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Stock>>> getWatchlist(String uid) async {
    try {
      final _result = await remoteDataSource.getWatchlist(uid);
      return Right(_result.map((e) => e.toWatchlistEntity).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, String>> removeFromWatchlist(int id) async {
    try {
      final _result = await remoteDataSource.removeFromWatchlist(id);
      return Right(_result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
