import 'dart:core';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;
  bool securePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );
  }

  @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Container(
  //       // padding: const EdgeInsets.all(24),
  //       child: Center(
  //         child: SafeArea(
  //           child: SingleChildScrollView(
  //             child: SizedBox(
  //               height: size.height,
  //               child: Stack(
  //                 children: [
  //                   SizedBox(
  //                     height: size.height,
  //                     child: Image.asset(
  //                       'img/turbine.jpg',
  //                       // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
  //                       fit: BoxFit.fitHeight,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Column(
  //                       children: [
  //                         Expanded(
  //                           child: SizedBox(),
  //                         ),
  //                         Expanded(
  //                           flex: 7,
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(30),
  //                             child: BackdropFilter(
  //                               filter:
  //                                   ImageFilter.blur(sigmaY: 25, sigmaX: 25),
  //                               child: SizedBox(
  //                                 width: size.width * .9,
  //                                 child: Column(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Padding(
  //                                       padding: EdgeInsets.only(
  //                                         top: size.width * .15,
  //                                         bottom: size.width * .1,
  //                                       ),
  //                                       child: Text(
  //                                         'SIGN IN',
  //                                         style: TextStyle(
  //                                           fontSize: 25,
  //                                           fontWeight: FontWeight.w600,
  //                                           color: Colors.white.withOpacity(.8),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     // loginForm(),
  //                                     RichText(
  //                                       text: TextSpan(
  //                                         text: 'Forgotten password!',
  //                                         style: const TextStyle(
  //                                           color: Colors.white,
  //                                         ),
  //                                         recognizer: TapGestureRecognizer()
  //                                           ..onTap = () {
  //                                             HapticFeedback.lightImpact();
  //                                           },
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: size.width * .3),
  //                                     loginButton(),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: SizedBox(),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             // child: CustomScrollView(
  //             // scrollDirection: Axis.vertical,
  //             // chi
  //             // slivers: <Widget>[
  //             //   SliverList(
  //             //     delegate: SliverChildListDelegate.fixed([
  //             //       loginHeaderWidget(),
  //             //       loginForm(),
  //             //       loginButton(),
  //             //     ]),
  //             //   ),
  //             // ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'img/turbine.jpg',
                    // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Manajemen Aset',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  component(
                                    Icons.email_outlined,
                                    'Email...',
                                    false,
                                    true,
                                  ),
                                  component(
                                    Icons.lock_outline,
                                    'Password...',
                                    true,
                                    false,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Forgotten password!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // HapticFeedback.lightImpact();
                                          // Fluttertoast.showToast(
                                          //   msg:
                                          //       'Forgotten password! button pressed',
                                          // );
                                        },
                                    ),
                                  ),
                                  SizedBox(height: size.width * .3),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      signIn();
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const MainPage(),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        controller: isEmail ? emailController : passController,
        obscureText: isEmail ? false : securePassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: securePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    if (securePassword) {
                      setState(() {
                        securePassword = false;
                      });
                    } else {
                      setState(() {
                        securePassword = true;
                      });
                    }
                  },
                )
              : null,
        ),
      ),
    );
  }
}

// widget header
Widget loginHeaderWidget() {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Image.asset(
        "img/login.png",
        width: 200,
      ),
    ],
  );
}

// Button untuk login dengan email dan password
Widget loginButton() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    width: double.infinity,
    child: ElevatedButton(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      onPressed: () {
        // signIn();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const MainPage(),
        //   ),
        // );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
