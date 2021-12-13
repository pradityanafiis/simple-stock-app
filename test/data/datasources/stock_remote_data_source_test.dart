import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:simple_stock_app/data/datasources/stock_remote_data_source.dart';
import 'package:simple_stock_app/data/models/stock_model.dart';

import '../../dummy_data/dummy_data.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late final MockHttpClient _mockHttpClient;
  late final StockRemoteDataSourceImpl _dataSource;

  setUpAll(() {
    _mockHttpClient = MockHttpClient();

    _dataSource = StockRemoteDataSourceImpl(
      client: _mockHttpClient,
    );
  });

  group('Get List of Stock', () {
    final _testListOfStock = StockModel.createList(DummyData.listOfStock);

    test('should return list of Stock when the response code is 200', () async {
      // arrange
      when(() => _mockHttpClient.get(
                Uri.parse(
                    'https://finnhub.io/api/v1/stock/symbol?exchange=JK&mic=XIDX'),
                headers: {
                  'X-Finnhub-Token': 'c6q2lkqad3i891nj0agg',
                },
              ))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(DummyData.listOfStock), 200));

      // act
      final _result = await _dataSource.getStock();

      // assert
      expect(_result, equals(_testListOfStock));
    });

    test('should throw a Exception when the response code is other than 200',
        () {
      // arrange
      when(() => _mockHttpClient.get(
            Uri.parse(
                'https://finnhub.io/api/v1/stock/symbol?exchange=JK&mic=XIDX'),
            headers: {
              'X-Finnhub-Token': 'c6q2lkqad3i891nj0agg',
            },
          )).thenAnswer((_) async => http.Response('Bad Request', 400));

      // act
      final _result = _dataSource.getStock();

      // assert
      expect(() => _result, throwsA(isA<Exception>()));
    });
  });

  group('Get Watchlist', () {
    const _uid = 'gjVgVwcdrQThils0ahU88REsknE2';
    final _testWatchlist = StockModel.createWatchlist(
        DummyData.watchlist['data'] as List<dynamic>);

    test('should return list of Watchlist when the response code is 200',
        () async {
      // arrange
      when(() => _mockHttpClient.get(
                Uri.parse('http://192.168.0.106:8000/api/stock/$_uid'),
              ))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(DummyData.watchlist), 200));

      // act
      final _result = await _dataSource.getWatchlist(_uid);

      // assert
      expect(_result, equals(_testWatchlist));
    });

    test('should throw a Exception when the response code is other than 200',
        () {
      // arrange
      when(() => _mockHttpClient.get(
            Uri.parse('http://192.168.0.106:8000/api/stock/$_uid'),
          )).thenAnswer((_) async => http.Response('Bad Request', 400));

      // act
      final _result = _dataSource.getWatchlist(_uid);

      // assert
      expect(() => _result, throwsA(isA<Exception>()));
    });
  });

  group('Add to Watchlist', () {
    const _uid = 'gjVgVwcdrQThils0ahU88REsknE2';
    const _testStockModel = StockModel(
      id: 116,
      description: 'PT Itama Ranoraya Tbk',
      symbol: 'IRRA',
    );

    test('should return StockModel when the response code is 201', () async {
      // arrange
      when(() => _mockHttpClient.post(
                Uri.parse('http://192.168.0.106:8000/api/stock'),
                body: {
                  "uid": _uid,
                  "symbol": _testStockModel.symbol,
                  "description": _testStockModel.description,
                },
              ))
          .thenAnswer((_) async =>
              http.Response(jsonEncode(DummyData.addToWatchlistResponse), 201));

      // act
      final _result = await _dataSource.addToWatchlist(_testStockModel, _uid);

      // assert
      expect(_result, equals(_testStockModel));
    });

    test('should throw a Exception when the response code is other than 201',
        () {
      // arrange
      when(() => _mockHttpClient.post(
            Uri.parse('http://192.168.0.106:8000/api/stock'),
            body: {
              "uid": _uid,
              "symbol": _testStockModel.symbol,
              "description": _testStockModel.description,
            },
          )).thenAnswer((_) async => http.Response('Bad Request', 400));

      // act
      final _result = _dataSource.addToWatchlist(_testStockModel, _uid);

      // assert
      expect(() => _result, throwsA(isA<Exception>()));
    });
  });

  group('Remove from Watchlist', () {
    const _id = 123;
    const _testStringResponse = 'Stock removed from watchlist';

    test('should return string when the response code is 200', () async {
      // arrange
      when(() => _mockHttpClient.delete(
                Uri.parse('http://192.168.0.106:8000/api/stock/$_id'),
              ))
          .thenAnswer((_) async => http.Response(
              jsonEncode(DummyData.removeFromWatchlistResponse), 200));

      // act
      final _result = await _dataSource.removeFromWatchlist(_id);

      // assert
      expect(_result, equals(_testStringResponse));
    });

    test('should throw a Exception when the response code is other than 200',
        () {
      // arrange
      when(() => _mockHttpClient.delete(
            Uri.parse('http://192.168.0.106:8000/api/stock/$_id'),
          )).thenAnswer((_) async => http.Response('Bad Request', 400));

      // act
      final _result = _dataSource.removeFromWatchlist(_id);

      // assert
      expect(() => _result, throwsA(isA<Exception>()));
    });
  });
}
