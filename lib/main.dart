import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen.dart';
import 'package:tic_tac_toe/home_screen.dart';
import 'package:tic_tac_toe/register_form.dart';
import 'package:tic_tac_toe/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Function? navigate;

  try {
    FirebaseAuth.instance.authStateChanges().listen((data) {
      if (data != null) {
        // Navigator.pushNamed(context, '/game');
        print('logged in');
        if (navigate != null) {
          navigate!('/game');
        }
      } else {
        // Navigator.pushNamed(context, '/');
        print('logged out');
        if (navigate != null) {
          navigate!('/login');
        }
      }
    });
  } catch (err) {
    print(err);
  }

  void navFunction(Function navigateFunction) {
    navigate = navigateFunction;
  }

  runApp(MainApp(navFunction: navFunction));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.navFunction});

  final Function navFunction;

  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  Function navigate() {
    return (String where) {
      if (navigatorKey == null) return;
      navigatorKey!.currentState!.pushNamed(where);
    };
  }

  @override
  Widget build(BuildContext context) {
    navFunction(navigate);
    return MaterialApp(navigatorKey: navigatorKey, routes: {
      '/': (context) => HomeScreen(),
      '/login': (context) => SignInForm(),
      '/register': (context) => RegisterForm(),
      '/game': (context) => GameScreen(),
    });
  }
}
