import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Color.fromARGB(225, 0, 74, 173),
          ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}