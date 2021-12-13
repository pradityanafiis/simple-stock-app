import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_stock_app/presentation/pages/main_page.dart';
import 'package:simple_stock_app/presentation/provider/firebase_auth_notifier.dart';
import 'package:simple_stock_app/presentation/widgets/custom_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Simple Stock App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'Please authenticate yourself',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  (!context.watch<FirebaseAuthNotifier>().isStateBusy)
                      ? ElevatedButton.icon(
                          onPressed: _onTapFunction,
                          icon: const FaIcon(FontAwesomeIcons.google),
                          label: const Text('Sign In with Google'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          );
        }

        return const MainPage();
      },
    );
  }

  void _onTapFunction() async {
    try {
      final _result =
          await context.read<FirebaseAuthNotifier>().signInWithGoogle();

      showCustomSnackBar(
        context: context,
        message: 'Welcome, ${_result.user!.displayName!}',
        isError: false,
      );
    } catch (e) {
      showCustomSnackBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}
