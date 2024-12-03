import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/auth_notifier.dart';
import 'package:tic_tac_toe/game_screen.dart';
import 'package:tic_tac_toe/home_screen.dart';
import 'package:tic_tac_toe/sign_in_form.dart';
import 'package:tic_tac_toe/sign_up_form.dart';
import 'package:tic_tac_toe/theme_notifier.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthNotifier()),
      ChangeNotifierProvider(create: (context) => ThemeNotifier(prefs: prefs)),
    ],
    child: const MainApp(),
  ));
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authNotifier = Provider.of<AuthNotifier>(context, listen: false);

      authNotifier.addListener(() {
        if (authNotifier.user != null) {
          navigatorKey!.currentState!
              .pushNamedAndRemoveUntil('/game', (route) => false);
        } else {
          navigatorKey!.currentState!
              .pushNamedAndRemoveUntil('/', (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
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
              backgroundColor: Colors.red,
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          themeMode:
              themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          navigatorKey: navigatorKey,
          routes: {
            '/': (context) => const HomeScreen(),
            '/login': (context) => const SignInForm(),
            '/register': (context) => SignUpForm(),
            '/game': (context) => const GameScreen(),
          });
    });
  }
}
