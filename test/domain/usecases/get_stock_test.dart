import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/domain/usecases/get_stock.dart';

import 'mock_stock_repository.dart';

void main() {
  late final MockStockRepository _mockStockRepository;
  late final GetStock _usecase;

  setUpAll(() {
    _mockStockRepository = MockStockRepository();
    _usecase = GetStock(_mockStockRepository);
  });

  final _testListOfStock = <Stock>[];

  test('should return list of Stock from the repository', () async {
    // arrange
    when(() => _mockStockRepository.getStock())
        .thenAnswer((_) async => Right(_testListOfStock));

    // act
    final _result = await _usecase.execute();

    // assert
    expect(_result, Right(_testListOfStock));
  });
}
