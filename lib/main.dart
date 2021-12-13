import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simple_stock_app/firebase_options.dart';
import 'package:simple_stock_app/presentation/pages/login_page.dart';
import 'package:simple_stock_app/presentation/provider/firebase_auth_notifier.dart';
import 'package:simple_stock_app/presentation/provider/stock_notifier.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StockNotifier>(create: (_) => di.locator()),
        ChangeNotifierProvider<FirebaseAuthNotifier>(
            create: (_) => di.locator())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Stock App',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
