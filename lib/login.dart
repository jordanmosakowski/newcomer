import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '393632820297-8h063039t8dlc3kfmeuofdheafab54to.apps.googleusercontent.com');

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      backgroundColor: Color.fromARGB(255, 4, 14, 37),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/templogo2.png', // Replace with the actual path
                width: 350,
              ),
              Container(height: 20),
              TextField(
                controller: emailController,
                onChanged: (_) {
                  setState(() {
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              Container(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: (EmailValidator.validate(emailController.text) && passwordController.text.isNotEmpty) ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if(EmailValidator.validate(emailController.text) && passwordController.text.isNotEmpty) {
                          print("Signing up");
                          try {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            print(credential.user);
                            Navigator.pushNamed(context, "/profile");
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('The password provided is too weak.'),
                                ),
                              );
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('The account already exists for that email.'),
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text("Sign up"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if(EmailValidator.validate(emailController.text) && passwordController.text.isNotEmpty) {
                          print("Logging in");
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            print(credential.user);
                            Navigator.pushNamed(context, "/profile");
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("No user found for that email.")),
                              );
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Wrong password provided for that user.")),
                              );
                              print('Wrong password provided for that user.');
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                      ),
                      child: Text("Log in"),
                    ),
                  ],
                ),
              )
              // ElevatedButton(
              //   onPressed: () async {
              //     User? user = await _handleSignIn();
              //     if (user != null) {
              //       print('Signed in with Google: ${user.displayName}');
              //       Navigator.pushNamed(context, '/questionnaire');
              //     }
              //   },
              //   child: Text('Sign in with Google'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
