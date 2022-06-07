import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:yand_map/map_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(19.0, 69.0, 19.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("lib/assets/main_logo.png"),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  const Text('Добрый день!',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(76, 80, 95, 1),
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w800
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  const Text('Fellow Trav',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(16, 168, 229, 1),
                      )),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  TextField(
                    controller: emailController,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromRGBO(76, 80, 95, 1),
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline_outlined),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(208, 208, 208, 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(
                            208, 208, 208, 1), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: Color.fromRGBO(
                              16, 168, 229, 1), width: 2)
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(76, 80, 95, 1)
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(208, 208, 208, 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(
                            208, 208, 208, 1), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: Color.fromRGBO(
                              16, 168, 229, 1), width: 2)
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  const Align(
                    child: Text("Забыли пароль?",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(149, 149, 149, 1),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  ElevatedButton(
                      onPressed: signIn,
                      child: const Text("ВОЙТИ",
                          style: TextStyle(
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          )
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Color.fromRGBO(16, 168, 229, 1)),
                              )
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(166.23, 47))
                      )
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Нет аккаунта?",
                          style: TextStyle(
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(149, 149, 149, 1),
                              fontSize: 14
                          )
                      ),
                      TextButton(
                        child: const Text("Зарегистрируйтесь",
                          style: TextStyle(
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(16, 168, 229, 1),
                              fontSize: 14
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/reg');
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(19.0, 69.0, 19.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("lib/assets/main_logo.png"),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  const Text('Добрый день!',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(76, 80, 95, 1),
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w800
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  const Text('Fellow Trav',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(16, 168, 229, 1),
                      )),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  TextField(
                    controller: emailController,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromRGBO(76, 80, 95, 1),
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline_outlined),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(208, 208, 208, 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(
                            208, 208, 208, 1), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: Color.fromRGBO(
                              16, 168, 229, 1), width: 2)
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(76, 80, 95, 1)
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(208, 208, 208, 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(
                            208, 208, 208, 1), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: Color.fromRGBO(
                              16, 168, 229, 1), width: 2)
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  const Align(
                    child: Text("Забыли пароль?",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(149, 149, 149, 1),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  ElevatedButton(
                      onPressed: signIn,
                      child: const Text("ВОЙТИ",
                          style: TextStyle(
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          )
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Color.fromRGBO(16, 168, 229, 1)),
                              )
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(166.23, 47))
                      )
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Нет аккаунта?",
                          style: TextStyle(
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(149, 149, 149, 1),
                              fontSize: 14
                          )
                      ),
                      TextButton(
                        child: const Text("Зарегистрируйтесь",
                          style: TextStyle(
                              fontFamily: "SFProDisplay",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(16, 168, 229, 1),
                              fontSize: 14
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/reg');
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Navigator.pushReplacementNamed(context, '/map');
  }
}
