import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authgoogle {
  bool signinbyGoogle = false;
  signinwithgoogle() async {
    GoogleSignIn _googlesignin = GoogleSignIn();
    try {
      signinbyGoogle = true;
      var user = await _googlesignin.signIn();

      if (user == null) {
        return;
      }

      final userdata = await user.authentication;
      final usercredential = await GoogleAuthProvider.credential(
          accessToken: userdata.accessToken, idToken: userdata.idToken);
      final result = FirebaseAuth.instance.signInWithCredential(usercredential);
      return result;
    } catch (e) {}
  }

  Future<void> signout() async {
    signinbyGoogle = false;

    FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
  }
}
