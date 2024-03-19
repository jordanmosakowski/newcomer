import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newcomer/pages/activities.dart';
import 'package:newcomer/pages/chat_list.dart';
import 'package:newcomer/pages/questionnaire.dart';
import 'package:newcomer/pages/update_user.dart';
import 'package:provider/provider.dart';
import 'package:newcomer/pages/chat.dart';
import 'firebase_options.dart';
import 'login.dart';

final router = FluroRouter();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
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
  Handler profileHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const UpdateUserProfile();
  });
  Handler activitiesHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return Activities(params["id"][0]);
  });

  router.define("/", handler: loginHandler);
  router.define("/questionnaire", handler: questionnaireHandler);
  router.define("/profile", handler: profileHandler);
  router.define("/chats/:id", handler: chatHandler);
  router.define("/chats", handler: chatListHandler);
  router.define("/activities/:id", handler: activitiesHandler);
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
              bodyLarge: GoogleFonts.redHatDisplay(textStyle: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 4, 14, 37)
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white, fontSize: 25),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 60, 60, 60),
                textStyle: GoogleFonts.redHatDisplay(textStyle: TextStyle(fontSize: 25)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                ),
              ),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 4, 14, 37),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
        ));
  }
}