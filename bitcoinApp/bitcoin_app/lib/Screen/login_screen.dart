import 'package:flutter/material.dart';

import '../Model/user_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Welcome"),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    TextEditingController textEditingControllerEmail = TextEditingController();
    TextEditingController textEditingControllerPassword =
        TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
            child: Image.asset(
              "images/login.png",
              width: 500,
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: TextFormField(
              validator: (value) => validateEmail(value),
              controller: textEditingControllerEmail,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'email@gmail.com',
                helperText: 'Enter the Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextFormField(
            controller: textEditingControllerPassword,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              hintText: '123456abcdefg',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          ElevatedButton(
              onPressed: () {
                if ((textEditingControllerPassword.text.length > 5) &&
                    (textEditingControllerEmail.text.length > 5)) {
                  User.add(User(
                      email: textEditingControllerEmail.text,
                      password: textEditingControllerPassword.text));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const HomeScreen()));
                }
              },
              child: const Text("Giriş")),
        ]),
      ),
    );
  }

  String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return "";
    }
  }
}
