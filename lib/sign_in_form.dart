import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/app_bar.dart';
import 'package:tic_tac_toe/auth_notifier.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String emailError = '';
  String passwordError = '';
  String otherError = '';
  bool isLoading = false;
  bool passwordVisible = false;

  void login(BuildContext context) async {
    setState(() {
      emailError = '';
      passwordError = '';
      otherError = '';
      isLoading = true;
      passwordVisible = false;
    });
    if (!_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      await authNotifier.signIn(emailController.text, passwordController.text);
    } on FirebaseAuthException catch (err) {
      if (!context.mounted) return;

      setState(() {
        emailError = err.code == 'invalid-email' ? err.message! : '';
        passwordError = err.code == 'wrong-password' ? err.message! : '';
        otherError = ['invalid-email', 'wrong-password'].contains(err.code)
            ? ''
            : err.message!;
        isLoading = false;
        _formKey.currentState!.validate();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          content: Text(err.message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'TIC TAC TOE URA 2024 - LOGIN'),
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
                        Text('Authentication',
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: 16),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (emailError.isNotEmpty) {
                              return emailError;
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (passwordError.isNotEmpty) {
                              return passwordError;
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        otherError.isNotEmpty
                            ? Text(otherError,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ))
                            : const SizedBox.shrink(),
                        ElevatedButton.icon(
                            icon: isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator())
                                : null,
                            onPressed: isLoading ? null : () => login(context),
                            label: const Text("LOGIN")),
                        const SizedBox(height: 16),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text('Don\'t have an account? Register',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline)))
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
