// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class PostAsTecher extends StatefulWidget {
  const PostAsTecher({Key? key}) : super(key: key);

  @override
  State<PostAsTecher> createState() => _PostAsTecherState();
}

class _PostAsTecherState extends State<PostAsTecher> {
  late TextEditingController classNameController,
      subjectController,
      timingController,
      qualificationController,
      descriptionController;
  String? name = '', email = '', message = '';

  @override
  void initState() {
    super.initState();
    classNameController = TextEditingController();
    subjectController = TextEditingController();
    timingController = TextEditingController();
    qualificationController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    classNameController.dispose();
    subjectController.dispose();
    timingController.dispose();
    qualificationController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: context.accentColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Name: ',
                                style: TextStyle(
                                    color: context.cardColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(name.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Email: ',
                                style: TextStyle(
                                    color: context.cardColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Message: ',
                                style: TextStyle(
                                    color: context.cardColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          message.toString(),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: context.cardColor,
                    child: const Text("Add"),
                    onPressed: () async {
                      final name = await openDialog();
                      final email = await openDialog();
                      final message = await openDialog();

                      if (name == null ||
                          name.isEmpty && email == null ||
                          email!.isEmpty && message == null ||
                          message!.isEmpty) return;
                      setState(() {
                        this.name = name;
                        this.email = email;
                        this.message = message;
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void submit() {
    Navigator.of(context).pop();
  }

  Future<void> postAsTeacher(
      String className, subject, timings, qualification, description) async {
    CollectionReference teacherPost =
        FirebaseFirestore.instance.collection('teacherPost');
    teacherPost.add({
      'className': className,
      'subject': subject,
      'qualification': qualification,
      'description': description
    });
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Teacher'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: classNameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Class',
                      icon: Icon(Icons.account_box),
                    ),
                  ),
                  TextFormField(
                    controller: subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  TextFormField(
                    controller: timingController,
                    decoration: const InputDecoration(
                      labelText: 'Timings',
                      icon: Icon(Icons.message),
                    ),
                  ),
                  TextFormField(
                    controller: qualificationController,
                    decoration: const InputDecoration(
                      labelText: 'Qualification',
                      icon: Icon(Icons.message),
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Discription',
                      icon: Icon(Icons.message),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            RaisedButton(
                child: const Text("Submit"),
                onPressed: () {
                  postAsTeacher(
                      classNameController.text,
                      subjectController.text,
                      timingController.text,
                      qualificationController.text,
                      descriptionController.text);
                })
          ],
        );
      });
}
