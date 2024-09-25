import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign up a new user
  static Future<String?> signUp(String email, String password) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return credential.user!.uid;
      }

      return null;

    } catch (e) {

      return null;

    }
  }

  // logging in
  static Future<String?> signIn(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        );

      if (credential.user != null) {
        return credential.user!.uid;
      }

      return null;

    } catch (e) {

      return null;

    }
  }

  // logging out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
