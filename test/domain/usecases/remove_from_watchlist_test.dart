import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_stock_app/domain/usecases/remove_from_watchlist.dart';

import 'mock_stock_repository.dart';

void main() {
  late final MockStockRepository _mockStockRepository;
  late final RemoveFromWatchlist _usecase;

  setUpAll(() {
    _mockStockRepository = MockStockRepository();
    _usecase = RemoveFromWatchlist(_mockStockRepository);
  });

  const _id = 1;
  const _message = 'Stock removed from watchlist';

  test('should return String from the repository', () async {
    // arrange
    when(() => _mockStockRepository.removeFromWatchlist(_id))
        .thenAnswer((_) async => const Right(_message));

    // act
    final _result = await _usecase.execute(_id);

    // assert
    expect(_result, const Right(_message));
  });
}
