import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_product/components/primary_button.dart';
import 'package:search_product/components/primary_text_field.dart';
import 'package:search_product/modules/authentication/models/user.dart';

import '../../authentication/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212332),
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color(0xFF212332),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryTextField(
                labelText: "Email",
                controller: email,
              ),
              SizedBox(
                height: 15,
              ),
              PrimaryTextField(
                labelText: "Password",
                controller: password,
                obscureText: !isPasswordVisible,
                withTogglePasswordIcon: true,
                onPasswordIconPresssed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () {
                  context.read<AuthBloc>().add(
                        LoggedIn(
                          UserModel(
                              email: email.text,
                              name: "Alexander Graham Bell",
                              password: password.text,
                              phone: "088221356742",
                              username: "alexander"),
                        ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
