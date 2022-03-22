// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_app_fyp/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpAsStudent extends StatefulWidget {
  @override
  State<SignUpAsStudent> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpAsStudent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final List<String> _city = [
    'Karachi',
    'Islamabad',
    'Lahore',
    'Peshawar'
  ]; // Option 2
  String? _selectedCity = '';

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      await Navigator.pushNamed(context, MyRoutes.signUpAsStudent);
      setState(() {
        changeButton = false;
      });
    }
  }

  void signUp() {
    final String emailTXT = _emailController.text.trim();
    final String passwordTXT = _passwordController.text.trim();

    if (emailTXT.isNotEmpty && passwordTXT.isNotEmpty) {
      _auth
          .createUserWithEmailAndPassword(
        email: emailTXT,
        password: passwordTXT,
      )
          .then((user) {
        _db
            .collection('Student')
            .doc('user')
            .collection('StudentSignUpUsers')
            .doc(user.user!.uid)
            .set({
          'name': _nameController,
          'email': emailTXT,
          'phoneNumber': _phoneNumController,
          'city': _selectedCity,
          'lastSeen': DateTime.now(),
          'signInMethod': user.user!.providerData[0].providerId
        });

        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text('Done'),
                content: const Text('Signing Successful'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.signInAsStudent);
                      },
                      child: const Text('OK')),
                ],
              );
            });
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text('Error'),
                content: const Text("Sign Up unsuccessfull.."),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK')),
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
              title: const Text('Error'),
              content: const Text('Please Provide Email and Password..'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK')),
              ],
            );
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
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text(
                      'SIGN UP',
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.cardColor),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter your Name",
                                    labelText: "Name",
                                  ),
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter your email",
                                    labelText: "Email",
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: DropdownButton(
                                    isExpanded: true,
                                    // Not necessary for Option 1

                                    items: _city.map((city) {
                                      return DropdownMenuItem(
                                        child: Text(city),
                                        value: city,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCity = newValue.toString();
                                      });
                                    },
                                    hint: _selectedCity == ''
                                        ? const Text('Select a city..')
                                        : Text(
                                            _selectedCity!,
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Password",
                                    labelText: "Password",
                                  ),
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "Enter Phone Number",
                                    labelText: "Phone",
                                  ),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Retype your password",
                                    labelText: "Retype Password",
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      changeButton ? 50 : 8),
                                  child: InkWell(
                                    onTap: () => signUp(),
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
                                              "SIGN UP",
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
    );
  }
}
