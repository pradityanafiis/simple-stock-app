import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_stock_app/domain/entities/stock.dart';
import 'package:simple_stock_app/presentation/provider/stock_notifier.dart';
import 'package:simple_stock_app/presentation/widgets/stock_widget.dart';

class SearchStockDelegate extends SearchDelegate<Stock> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final _theme = Theme.of(context);
    return _theme.copyWith(
      hintColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: InputBorder.none,
      ),
      textTheme: _theme.textTheme.copyWith(
        headline6: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ), // query Color
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<StockNotifier>().searchStock(query);

    return Container(
      color: const Color(0xffF5F5F5),
      child: Consumer<StockNotifier>(
        builder: (context, value, _) {
          if (query.isEmpty) {
            return const Center(
              child: Text('Please enter some keyword'),
            );
          } else if (value.filteredStockList.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: value.filteredStockList.length,
              itemBuilder: (_, index) =>
                  StockWidget(value.filteredStockList[index]),
              separatorBuilder: (_, index) => const SizedBox(height: 8.0),
            );
          } else if (value.filteredStockList.isEmpty) {
            return Center(
              child: Text(
                  "'$query' not found, please try again with another keyword"),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
