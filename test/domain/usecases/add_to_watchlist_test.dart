import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/domain/usecases/add_to_watchlist.dart';

import 'mock_stock_repository.dart';

void main() {
  late final MockStockRepository _mockStockRepository;
  late final AddToWatchlist _usecase;

  setUpAll(() {
    _mockStockRepository = MockStockRepository();
    _usecase = AddToWatchlist(_mockStockRepository);
  });

  const _uid = 'gjVgVwcdrQThils0ahU88REsknE2';
  const _testStock = Stock(
    description: 'PT Itama Ranoraya Tbk',
    symbol: 'IRRA',
  );

  test('should return Stock from the repository', () async {
    // arrange
    when(() => _mockStockRepository.addToWatchlist(_testStock, _uid))
        .thenAnswer((_) async => const Right(_testStock));

    // act
    final _result = await _usecase.execute(_testStock, _uid);

    // assert
    expect(_result, const Right(_testStock));
  });
}
