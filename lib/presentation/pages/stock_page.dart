import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:simple_stock_app/presentation/pages/search_stock_delegate.dart';
import 'package:simple_stock_app/presentation/provider/stock_notifier.dart';
import 'package:simple_stock_app/presentation/widgets/stock_widget.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final _firebaseAuth = GetIt.I.get<FirebaseAuth>();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StockNotifier>().fetch();
      context
          .read<StockNotifier>()
          .fetchWatchlist(_firebaseAuth.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: const Text('Stock'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchStockDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<StockNotifier>(
        builder: (context, value, _) {
          if (value.isStateBusy) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.stockList.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: value.stockList.length,
              itemBuilder: (_, index) => StockWidget(value.stockList[index]),
              separatorBuilder: (_, index) => const SizedBox(height: 8.0),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
