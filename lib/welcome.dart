import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();

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
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20), // Add horizontal padding
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Enter your email',
                  ),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _sendEmailVerification(context);
              },
              child: Text('Send Email Verification'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendEmailVerification(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification email sent. Check your inbox.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email already verified.'),
        ),
      );
    }
  }
}
