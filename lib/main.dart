// @dart=2.9

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app_fyp/screens/homeScreen.dart';
import 'package:tutor_app_fyp/screens/postAsTeacher.dart';
import 'package:tutor_app_fyp/screens/roleScreen.dart';
import 'package:tutor_app_fyp/screens/splashScreen.dart';
import 'package:tutor_app_fyp/screens/tutorBySubject.dart';
import 'package:tutor_app_fyp/screens/tutors_dashboard.dart';
import 'package:tutor_app_fyp/themes/themes.dart';
import 'package:tutor_app_fyp/userLogin/signIN/signIn_asStudent.dart';
import 'package:tutor_app_fyp/userLogin/signIN/signIn_asTeacher.dart';
import 'package:tutor_app_fyp/userLogin/signUP/signUpAsStudent.dart';
import 'package:tutor_app_fyp/userLogin/signUP/signUpAsTeacher.dart';
import 'package:tutor_app_fyp/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splashScreenRoute,
      routes: {
        "/": (context) => SignInAsTeacher(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.signUpAsStudent: (context) => SignUpAsStudent(),
        MyRoutes.signUpAsTeacher: (context) => SignUpAsTeacher(),
        MyRoutes.roleRoute: (context) => RolePage(),
        MyRoutes.tutorDashBoardRoute: (context) => TutorDashBoard(),
        MyRoutes.postAsTeacher: (context) => PostAsTecher(),
        MyRoutes.splashScreenRoute: (context) => SplashScreen(),
        MyRoutes.signInAsStudent: (context) => SignInAsStudent(),
        MyRoutes.signInAsTeacher: (context) => SignInAsTeacher(),
        MyRoutes.tutorBySubject: (context) => TutorBySubject(),
      },
    );
  }
}
