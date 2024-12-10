import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            title: const Text('Game'),
            onTap: () => Navigator.pushNamed(context, '/game'),
          ),
          Expanded(child: Container()),
          ListTile(
            title: const Text('Logout'),
            onTap: () => logout(),
          ),
        ],
      ),
    );
  }
}
