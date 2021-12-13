import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/presentation/provider/stock_notifier.dart';

class StockWidget extends StatelessWidget {
  final _firebaseAuth = GetIt.I.get<FirebaseAuth>();
  final Stock stock;
  final bool isDeleteActive;

  StockWidget(
    this.stock, {
    Key? key,
    this.isDeleteActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  stock.symbolToDisplay,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  stock.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Consumer<StockNotifier>(
            builder: (context, value, child) {
              if (value.watchlist.contains(stock)) {
                return GestureDetector(
                  onTap: () {
                    if (isDeleteActive) {
                      context
                          .read<StockNotifier>()
                          .deleteFromWatchlist(stock.id!);
                      context
                          .read<StockNotifier>()
                          .refreshWatchlist(_firebaseAuth.currentUser!.uid);
                    }
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.binoculars,
                    color: Colors.brown,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    context.read<StockNotifier>().insertToWatchlist(
                        stock, _firebaseAuth.currentUser!.uid);
                    context
                        .read<StockNotifier>()
                        .refreshWatchlist(_firebaseAuth.currentUser!.uid);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.binoculars,
                    color: Colors.grey,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
