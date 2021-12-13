import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:simple_stock_app/data/models/stock_model.dart';

abstract class StockRemoteDataSource {
  Future<List<StockModel>> getStock();
  Future<StockModel> addToWatchlist(StockModel stock, String uid);
  Future<List<StockModel>> getWatchlist(String uid);
  Future<String> removeFromWatchlist(int id);
}

class StockRemoteDataSourceImpl extends StockRemoteDataSource {
  final http.Client client;
  // final FirebaseAuth firebaseAuth;

  StockRemoteDataSourceImpl({required this.client});

  @override
  Future<List<StockModel>> getStock() async {
    final _response = await client.get(
      Uri.parse('https://finnhub.io/api/v1/stock/symbol?exchange=JK&mic=XIDX'),
      headers: {
        'X-Finnhub-Token': 'c6q2lkqad3i891nj0agg',
      },
    );

    if (_response.statusCode == 200) {
      return StockModel.createList(jsonDecode(_response.body));
    } else {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<StockModel> addToWatchlist(StockModel stock, String uid) async {
    final _response = await client.post(
      Uri.parse('http://192.168.0.106:8000/api/stock'),
      body: {
        "uid": uid,
        "symbol": stock.symbol,
        "description": stock.description,
      },
    );

    if (_response.statusCode == 201) {
      return StockModel.fromJson(jsonDecode(_response.body)['data']);
    } else {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<List<StockModel>> getWatchlist(String uid) async {
    final _response = await client.get(
      Uri.parse('http://192.168.0.106:8000/api/stock/$uid'),
    );

    if (_response.statusCode == 200) {
      return StockModel.createWatchlist(jsonDecode(_response.body)['data']);
    } else {
      throw Exception('Server Exception');
    }
  }

  @override
  Future<String> removeFromWatchlist(int id) async {
    final _response = await client.delete(
      Uri.parse('http://192.168.0.106:8000/api/stock/$id'),
    );

    if (_response.statusCode == 200) {
      return jsonDecode(_response.body)['message'];
    } else {
      throw Exception('Server Exception');
    }
  }
}
