import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newcomer/pages/chat_list.dart';
import 'package:newcomer/pages/questionnaire.dart';
import 'package:provider/provider.dart';
import 'package:newcomer/pages/chat.dart';
import 'firebase_options.dart';
import 'login.dart';

final router = FluroRouter();

void main() async {
  Handler chatHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return ChatPage(params["id"][0]);
  });
  Handler chatListHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return ChatList();
  });
  Handler loginHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return WelcomeScreen();
  });
  Handler questionnaireHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const Questionnaire();
  });

  router.define("/", handler: loginHandler);
  router.define("/questionnaire", handler: questionnaireHandler);
  router.define("/chats/:id", handler: chatHandler);
  router.define("/chats", handler: chatListHandler);
  router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return WelcomeScreen();
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData(brightness: Brightness.dark).textTheme;
    return MultiProvider(
        providers: [
          StreamProvider<User?>.value(
              value: FirebaseAuth.instance.authStateChanges(),
              initialData: null),
        ],
        child: MaterialApp(
          onGenerateRoute: router.generator,
          title: 'Newcomer',
          theme: ThemeData(
            textTheme: GoogleFonts.redHatDisplayTextTheme(textTheme).copyWith(
              bodyMedium: GoogleFonts.josefinSans(textStyle: textTheme.bodyMedium),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          // home: WelcomeScreen(),
          // routes: {
          //   '/': (context) => WelcomeScreen(),
          //   '/questionnaire': (context) => const Questionnaire(),
          //   '/chats': (context) => const ChatList(),
          //   '/chat': (context) => const ChatPage("dzxuQznhsKK0FKOyT7Nb"),
          // },
        ));
  }
}