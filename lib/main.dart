import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.green,
              onPressed: () async {
                await signInWithGoogle();
              },
              child: Text('Sign in with Google'),
            ),
            SizedBox(
              width: double.infinity,
            ),
            RaisedButton(
              color: Colors.red,
              onPressed: () async {
                await signOut();
              },
              child: Text('sign out'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult authResult = await _auth.signInWithCredential(authCredential);
    FirebaseUser user = await _auth.currentUser();
    print('user email = ${user.email}');
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    print('sign out');
  }
}
