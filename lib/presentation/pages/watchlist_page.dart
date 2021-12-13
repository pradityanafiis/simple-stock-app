import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:simple_stock_app/presentation/provider/stock_notifier.dart';
import 'package:simple_stock_app/presentation/widgets/stock_widget.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final _firebaseAuth = GetIt.I.get<FirebaseAuth>();

  @override
  void initState() {
    super.initState();

    context
        .read<StockNotifier>()
        .fetchWatchlist(_firebaseAuth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: const Text('Stock Watchlist'),
      ),
      body: Consumer<StockNotifier>(
        builder: (context, value, _) {
          if (value.isStateBusy) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.watchlist.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: value.watchlist.length,
              itemBuilder: (_, index) => StockWidget(
                value.watchlist[index],
                isDeleteActive: true,
              ),
              separatorBuilder: (_, index) => const SizedBox(height: 8.0),
            );
          } else {
            return const Center(
              child: Text('Your watchlist is empty'),
            );
          }
        },
      ),
    );
  }
}
