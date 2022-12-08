import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/homepage.dart';
import 'package:todo_app/utils/provider.dart';
import 'package:todo_app/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserNotifier? _userNotifier;

  @override
  Widget build(BuildContext context) {
    _userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Dexter Health',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    )),
                Image.asset(
                  "assets/images/image.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Enter your email to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: emailValidation,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Continue'),
                      onPressed: () {
                        login(emailController.text);
                      },
                    )),
              ],
            ),
          )),
    );
  }

  login(email) async {
    if (formKey.currentState!.validate()) {
      var collection = FirebaseFirestore.instance.collection('users');
      collection.doc(email).set({"email": email}, SetOptions(merge: true));
      _userNotifier!.setEmail = email;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
