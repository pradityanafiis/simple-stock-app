import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_stock_app/data/datasources/stock_remote_data_source.dart';
import 'package:simple_stock_app/data/models/stock_model.dart';
import 'package:simple_stock_app/data/repositories/stock_repository_impl.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';

class MockStockRemoteDataSource extends Mock implements StockRemoteDataSource {}

void main() {
  late final StockRepositoryImpl _repository;
  late final MockStockRemoteDataSource _remoteDataSource;

  setUpAll(() {
    _remoteDataSource = MockStockRemoteDataSource();
    _repository = StockRepositoryImpl(remoteDataSource: _remoteDataSource);
  });

  const String _uid = 'gjVgVwcdrQThils0ahU88REsknE2';

  const _testStockModel = StockModel(
    description: 'PT Itama Ranoraya Tbk',
    symbol: 'IRRA',
  );

  const _testStock = Stock(
    description: 'PT Itama Ranoraya Tbk',
    symbol: 'IRRA',
  );

  final _testListOfStock = <Stock>[_testStock];

  final _testListOfStockModel = <StockModel>[_testStockModel];

  group('Get Stock', () {
    test(
        'should return list of Stock when the call to remote data source is successful',
        () async {
      // arrange
      when(() => _remoteDataSource.getStock())
          .thenAnswer((_) async => _testListOfStockModel);

      // act
      final _result = await _repository.getStock();
      final _resultList = _result.getOrElse(() => []);

      // assert
      verify(() => _remoteDataSource.getStock());
      expect(_resultList, _testListOfStock);
    });

    // test(
    //     'should return exception when the call to remote data source is unsuccessful',
    //     () async {
    //   // arrange
    //   when(() => _remoteDataSource.getStock()).thenThrow(Exception(''));

    //   // act
    //   final _result = await _repository.getStock();

    //   // assert
    //   verify(() => _remoteDataSource.getStock());
    //   expect(_result, equals(Left(Exception(''))));
    // });
  });

  group('Add Stock to Watchlist', () {
    const String _uid = 'gjVgVwcdrQThils0ahU88REsknE2';

    test(
        'should return Stock when the call to remote data source is successful',
        () async {
      // arrange
      when(() => _remoteDataSource.addToWatchlist(_testStockModel, _uid))
          .thenAnswer((_) async => _testStockModel);

      // act
      final _result = await _repository.addToWatchlist(_testStock, _uid);

      // assert
      verify(() => _remoteDataSource.addToWatchlist(_testStockModel, _uid));
      expect(_result, equals(const Right(_testStock)));
    });
  });

  group('Get Watchlist', () {
    test(
        'should return list of Stock when the call to remote data source is successful',
        () async {
      // arrange
      when(() => _remoteDataSource.getWatchlist(_uid))
          .thenAnswer((_) async => _testListOfStockModel);

      // act
      final _result = await _repository.getWatchlist(_uid);
      final _resultList = _result.getOrElse(() => []);

      // assert
      verify(() => _remoteDataSource.getWatchlist(_uid));
      expect(_resultList, _testListOfStock);
    });
  });

  group('Remove Stock from Watchlist', () {
    const _id = 1;
    const _message = 'Stock removed from watchlist';
    test(
        'should return String when the call to remote data source is successful',
        () async {
      // arrange
      when(() => _remoteDataSource.removeFromWatchlist(_id))
          .thenAnswer((_) async => _message);

      // act
      final _result = await _repository.removeFromWatchlist(_id);

      // assert
      verify(() => _remoteDataSource.removeFromWatchlist(_id));
      expect(_result, equals(const Right(_message)));
    });
  });
}
