import 'package:flutter/material.dart';
import 'package:tutor_app_fyp/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class RolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff46050C), Color(0xffAE0000)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    "YOUR ROLE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff46050C), Color(0xffAE0000)])),
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, MyRoutes.signInAsStudent),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(100)),
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "I AM A STUDENT",
                              style: TextStyle(
                                color: context.accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, MyRoutes.signInAsTeacher),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(100)),
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "I AM A TEACHER",
                              style: TextStyle(
                                color: context.accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
