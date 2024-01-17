import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '393632820297-8h063039t8dlc3kfmeuofdheafab54to.apps.googleusercontent.com');

  Future<User?> _handleSignIn() async {
    try {

      if(kIsWeb) {
            // Create a new provider
          GoogleAuthProvider googleProvider = GoogleAuthProvider();

          // Once signed in, return the UserCredential
          return (await FirebaseAuth.instance.signInWithPopup(googleProvider)).user;
      }
      else {
        final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          final UserCredential authResult =
              await _auth.signInWithCredential(credential);
          return authResult.user;
        }
      }
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/templogo2.png', // Replace with the actual path
              width: 350,
              height: 150,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                User? user = await _handleSignIn();
                if (user != null) {
                  print('Signed in with Google: ${user.displayName}');
                  Navigator.pushNamed(context, '/questionnaire');
                }
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
