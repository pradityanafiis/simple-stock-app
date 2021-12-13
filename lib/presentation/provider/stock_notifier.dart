import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/domain/usecases/add_to_watchlist.dart';
import 'package:simple_stock_app/domain/usecases/get_stock.dart';
import 'package:simple_stock_app/domain/usecases/get_watchlist.dart';
import 'package:simple_stock_app/domain/usecases/remove_from_watchlist.dart';
import 'package:simple_stock_app/presentation/provider/base_notifier.dart';

class StockNotifier extends BaseNotifier {
  final GetStock getStock;
  final AddToWatchlist addToWatchlist;
  final RemoveFromWatchlist removeFromWatchlist;
  final GetWatchlist getWatchlist;

  StockNotifier({
    required this.getStock,
    required this.addToWatchlist,
    required this.getWatchlist,
    required this.removeFromWatchlist,
  });

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Stock> _stockList = [];
  List<Stock> get stockList => _stockList;

  List<Stock> _filteredStockList = [];
  List<Stock> get filteredStockList => _filteredStockList;

  Future<void> fetch() async {
    _errorMessage = null;
    _stockList.clear();

    resetState();

    final _result = await getStock.execute();

    _result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (data) {
        _stockList = data;
      },
    );

    setStateIdle();
  }

  Future<void> searchStock(String query) async {
    _errorMessage = null;
    _filteredStockList.clear();

    _filteredStockList = _stockList
        .where((element) =>
            element.symbol.toLowerCase().contains(query.toLowerCase()) ||
            element.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> insertToWatchlist(Stock stock, String uid) async {
    _errorMessage = null;

    final _result = await addToWatchlist.execute(stock, uid);

    _result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (data) {},
    );

    refreshState();
  }

  List<Stock> _watchlist = [];
  List<Stock> get watchlist => _watchlist;

  Future<void> fetchWatchlist(String uid) async {
    _errorMessage = null;

    resetState();

    final _result = await getWatchlist.execute(uid);

    _result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (data) {
        _watchlist = data;
      },
    );

    setStateIdle();
  }

  Future<void> refreshWatchlist(String uid) async {
    final _result = await getWatchlist.execute(uid);

    _result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (data) {
        _watchlist = data;
      },
    );

    refreshState();
  }

  Future<void> deleteFromWatchlist(int id) async {
    _errorMessage = null;

    final _result = await removeFromWatchlist.execute(id);

    _result.fold(
      (failure) {
        _errorMessage = failure.toString();
      },
      (data) {},
    );

    refreshState();
  }
}
