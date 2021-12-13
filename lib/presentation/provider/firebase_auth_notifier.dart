import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_stock_app/presentation/provider/base_notifier.dart';

class FirebaseAuthNotifier extends BaseNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthNotifier(this._firebaseAuth);

  Future<UserCredential> signInWithGoogle() async {
    setStateBusy();

    final _user = await _googleSignIn.signIn();

    if (_user == null) {
      setStateIdle();
      throw Exception('Please select Google account');
    }

    final _auth = await _user.authentication;

    final _credential = GoogleAuthProvider.credential(
      accessToken: _auth.accessToken,
      idToken: _auth.idToken,
    );

    _googleSignIn.signOut();

    setStateIdle();

    return await _firebaseAuth.signInWithCredential(_credential);
  }
}
