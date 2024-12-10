import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/app_bar.dart';
import 'package:tic_tac_toe/app_drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();

  Future<void> saveProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'age': ageController.text,
      'sex': sexController.text,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  void initState() {
    super.initState();
    setupProfileListener();
  }

  void setupProfileListener() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        ageController.text = snapshot.data()!['age'];
        sexController.text = snapshot.data()!['sex'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Profile'),
        drawer: const AppDrawer(),
        body: Center(
          child: Card(
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderOnForeground: true,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Profile',
                              style: Theme.of(context).textTheme.headlineLarge),
                          const SizedBox(height: 16),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Age is required';
                              } else if (int.parse(value) < 18) {
                                return 'You must be at least 18 years old';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                            },
                            onFieldSubmitted: (_) {
                              _formKey.currentState?.validate();
                            },
                            controller: ageController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.cake),
                              labelText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: sexController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Sex',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                            },
                            onFieldSubmitted: (_) {
                              _formKey.currentState?.validate();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Sex is required';
                              } else if (value != 'male' && value != 'female') {
                                return 'Sex must be male or female';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              _formKey.currentState?.validate();
                              saveProfile();
                            },
                            child: const Text('Save'),
                          ),
                        ])),
              ),
            ),
          ),
        ));
  }
}
