import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:simple_stock_app/data/datasources/stock_remote_data_source.dart';
import 'package:simple_stock_app/data/repositories/stock_repository_impl.dart';
import 'package:simple_stock_app/domain/repositories/stock_repository.dart';
import 'package:simple_stock_app/domain/usecases/add_to_watchlist.dart';
import 'package:simple_stock_app/domain/usecases/get_stock.dart';
import 'package:simple_stock_app/domain/usecases/get_watchlist.dart';
import 'package:simple_stock_app/domain/usecases/remove_from_watchlist.dart';
import 'package:simple_stock_app/presentation/provider/firebase_auth_notifier.dart';
import 'package:simple_stock_app/presentation/provider/stock_notifier.dart';

final GetIt locator = GetIt.instance;

void init() {
  // EXTERNALS
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => FirebaseAuth.instance);

  // DATA SOURCES
  locator.registerLazySingleton<StockRemoteDataSource>(
      () => StockRemoteDataSourceImpl(
            client: locator(),
          ));

  // REPOSITORIES
  locator.registerLazySingleton<StockRepository>(
      () => StockRepositoryImpl(remoteDataSource: locator()));

  // USE CASES
  locator.registerLazySingleton(() => GetStock(locator()));
  locator.registerLazySingleton(() => AddToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveFromWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

  // NOTIFIER
  locator.registerFactory(() => StockNotifier(
        getStock: locator(),
        addToWatchlist: locator(),
        removeFromWatchlist: locator(),
        getWatchlist: locator(),
      ));

  locator.registerFactory(() => FirebaseAuthNotifier(locator()));
}
