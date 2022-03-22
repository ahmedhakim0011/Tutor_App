// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_app_fyp/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInAsStudent extends StatefulWidget {
  @override
  State<SignInAsStudent> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInAsStudent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      await Navigator.pushNamed(context, MyRoutes.tutorDashBoardRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff46050C), Color(0xffAE0000)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: context.cardColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'as STUDENT',
                        style: TextStyle(
                          color: context.cardColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xffAE0000), Color(0xff46050C)])),
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.cardColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 32),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    onChanged: (value) {
                                      name = value;
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter your Username",
                                      labelText: "USERNAME",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Username cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _passController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      labelText: "Password",
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Username cannot be empty";
                                      } else if (value.length < 6) {
                                        return "Password should be atleast 6";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot your password?',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(
                                        changeButton ? 50 : 8),
                                    child: InkWell(
                                      onTap: () => _signIn(),
                                      child: AnimatedContainer(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xffAE0000),
                                                Color(0xff46050C)
                                              ]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100.0)),
                                        ),
                                        duration: const Duration(seconds: 1),
                                        height: 50,
                                        width: changeButton ? 50 : 300,
                                        alignment: Alignment.center,
                                        child: changeButton
                                            ? const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              )
                                            : Text(
                                                "SIGN IN",
                                                style: TextStyle(
                                                  color: changeButton
                                                      ? Colors.yellowAccent
                                                      : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Divider(color: Colors.black),
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              MyRoutes.signUpAsStudent);
                                        },
                                        child: Text(
                                          'NEW USER ? SIGN UP HERE',
                                          style: TextStyle(
                                              color: context.accentColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
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

  void _signIn() async {
    String emailTXT = _emailController.text.trim();
    String passwodTXT = _passController.text.trim();

    if (emailTXT.isNotEmpty && passwodTXT.isNotEmpty) {
      _auth
          .signInWithEmailAndPassword(email: emailTXT, password: passwodTXT)
          .then((user) => {
                _db
                    .collection('Student')
                    .doc('user')
                    .collection('StudentSignUpUsers')
                    .doc(user.user!.uid)
                    .set({
                  'email': emailTXT,
                  'lastSeen': DateTime.now(),
                  'signInMethod': user.user!.providerData[0].providerId
                }),
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: Text('Done'),
                        content: Text('Signing Successful'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.tutorDashBoardRoute);
                              },
                              child: Text('OK')),
                        ],
                      );
                    })
              })
          .catchError((e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text('Error'),
                content: Text('Signing unccessfull'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('cancle')),
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text('Error'),
              content: Text('Please provide email and password'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('cancle')),
                FlatButton(
                    onPressed: () {
                      _emailController.text = '';
                      _passController.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text('OK')),
              ],
            );
          });
    }
  }
}
