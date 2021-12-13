import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_stock_app/presentation/pages/profile_page.dart';
import 'package:simple_stock_app/presentation/pages/stock_page.dart';
import 'package:simple_stock_app/presentation/pages/watchlist_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _controller;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUserCircle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartLine),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.binoculars),
            label: 'Watchlist',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _pageIndex,
        onTap: (index) {
          _controller.jumpToPage(index);

          setState(() {
            _pageIndex = index;
          });
        },
      ),
      body: PageView(
        controller: _controller,
        children: const [
          ProfilePage(),
          StockPage(),
          WatchlistPage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
