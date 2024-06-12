import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/chat/user_list.dart';
import 'package:flutter_chat/presentation/auth/register.dart';
import 'package:flutter_chat/service/auth_service.dart';

import '../widgets/my_widget/my_button.dart';

import '../widgets/my_widget/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final authService = AuthService();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            MyTextField(
              labelText: "Email",
              controller: emailController,
            ),
            MyTextField(
              labelText: "Password",
              controller: passwordController,
            ),
            MyButton(
              btnName: "LOGIN",
              onTap: () async {
                try {
                  await authService.signInWithEmailPassword(emailController.text, passwordController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserListPage(),
                      ));
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(e.toString()),
                          ));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You are not yet member?"),
                  InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const RegisterPage()), (Route<dynamic> route) => false),
                    child: const Text(
                      "Register now?",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
