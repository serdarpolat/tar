import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<String> register(String email, String password) async {
    try {
      var credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String myUid = "";

      var user = credential.user;

      if (user != null) {
        myUid = user.uid;
      }

      return myUid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "email";
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String myUid = "";

      var user = credential.user;

      if (user != null) {
        myUid = user.uid;
      }

      return myUid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "not";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "wrong";
      }

      return "";
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
