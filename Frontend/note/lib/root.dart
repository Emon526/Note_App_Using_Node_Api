import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/auth/login_page.dart';
import 'pages/home_page.dart';
import 'providers/auth_provider.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    log('root');
    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder<User?>(
      stream: authProvider.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          log('user ${user?.uid}');

          return user == null ? const LoginPage() : const HomePage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
