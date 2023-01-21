import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/auth.dart';
import 'package:manajemen_aset/login/login_screen.dart';

class AuthService extends StatelessWidget {
  const AuthService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Auth();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}