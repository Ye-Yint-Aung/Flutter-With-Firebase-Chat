import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/welcome/welcome.dart';
import 'package:flutter_chat/presentation/widgets/my_widget/my_button.dart';

import 'package:flutter_chat/service/auth_service.dart';

import '../widgets/my_widget/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey.withOpacity(0.5),
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "REGISTER",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            MyTextField(labelText: "Email", controller: emailController),
            MyTextField(labelText: "Password", controller: passwordController),
            MyTextField(labelText: "Confirm Password", controller: confirmPasswordController),
            MyButton(
              btnName: "REGISTER",
              onTap: () {
                final _auth = AuthService();
                if (passwordController.text == confirmPasswordController.text) {
                  try {
                    _auth.signUpWithEmailPassword(emailController.text, passwordController.text);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const WelcomePage()), (Route<dynamic> route) => false);
                  } catch (e) {
                    showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(e.toString()),
                            ));
                  }
                } else {
                  showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: Text("Password are not match!"),
                          ));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You are a member?"),
                  InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const WelcomePage()), (Route<dynamic> route) => false),
                    child: const Text(
                      "Login now?",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
