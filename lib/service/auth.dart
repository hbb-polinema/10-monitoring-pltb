import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/login/login_screen.dart';
import 'package:manajemen_aset/user/user_controller.dart';
import 'package:manajemen_aset/widget/drawer_admin.dart';

import '../widget/drawer.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Widget homePageManager = const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: UserController.streamRole(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snap.hasData) {
            String? role = snap.data?.data()?['role'];
            if (role == 'Admin') {
              return const DrawerAdmin();
            } else if (role == 'Pemilik Proyek') {
              return const MyDrawer();
            } else if (role == 'Petugas Lapangan') {
              return const MyDrawer();
            } else {
              return const LoginScreen();
            }
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
