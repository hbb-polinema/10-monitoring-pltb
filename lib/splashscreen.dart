import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthService()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: [
      //     Container(
      //       decoration: const BoxDecoration(
      //           color: Color.fromARGB(255, 24, 106, 199),
      //           gradient: LinearGradient(colors: [
      //             (Color.fromARGB(255, 24, 106, 199)),
      //             Color.fromARGB(255, 94, 171, 235)
      //           ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      //     ),
      //     Center(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(
      //                     "img/polinema.png",
      //                     height: 120.0,
      //                     width: 120.0,
      //                   ),
      //                   Image.asset(
      //                     "img/pln.png",
      //                     height: 120.0,
      //                     width: 120.0,
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           const Text(
      //             "Sistem Manajemen Aset",
      //             // textAlign: TextAlign.center,
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 20.0,
      //             ),
      //           ),
      //           const CircularProgressIndicator(
      //             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 24, 106, 199),
                gradient: LinearGradient(colors: [
                  (Color.fromARGB(255, 24, 106, 199)),
                  Color.fromARGB(255, 94, 171, 235)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "img/polinema.png",
                      height: 120.0,
                      width: 120.0,
                    ),
                    Image.asset(
                      "img/pln.png",
                      height: 120.0,
                      width: 120.0,
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Text(
                  "Sistem Manajemen Aset",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
