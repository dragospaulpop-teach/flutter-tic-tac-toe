import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Welcome to our app'),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Go to LogIn'))
        ],
      ),
    );
  }
}
