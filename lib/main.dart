import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen.dart';
import 'package:tic_tac_toe/home_screen.dart';
import 'package:tic_tac_toe/login_form.dart';
import 'package:tic_tac_toe/register_form.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    try {
      FirebaseAuth.instance.authStateChanges().listen((data) {
        if (data != null) {
          navigatorKey!.currentState!
              .pushNamedAndRemoveUntil('/game', (route) => false);
        } else {
          navigatorKey!.currentState!
              .pushNamedAndRemoveUntil('/', (route) => false);
        }
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo, brightness: Brightness.dark),
          brightness: Brightness.dark,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const HomeScreen(),
          '/login': (context) => SignInForm(),
          '/register': (context) => RegisterForm(),
          '/game': (context) => const GameScreen(),
        });
  }
}
