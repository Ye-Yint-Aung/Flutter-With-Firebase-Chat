import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/chat/user_list.dart';
import 'package:flutter_chat/presentation/auth/register.dart';
import 'package:flutter_chat/presentation/widgets/my_widget/my_button.dart';

import '../../service/auth_service.dart';
import '../widgets/my_widget/my_text_field.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final authService = AuthService();

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey.withOpacity(0.5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Text(
                  "HELLO - CHAT",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("LOGIN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              MyTextField(labelText: "Email", controller: emailController),
              const SizedBox(height: 20),
              MyTextField(labelText: "Password", controller: passwordController),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MyButton(
                  btnName: "Login",
                  onTap: () async {
                    try {
                      await authService.signInWithEmailPassword(emailController.text, passwordController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserListPage()));
                    } catch (e) {
                      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString())));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You are not yet member?",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white30)),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                          (Route<dynamic> route) => false),
                      child: const Text("REGISTER NOW",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(" GOOGLE", style: TextStyle(color: Colors.blue)),
                    Text("GITHUB", style: TextStyle(color: Colors.blue)),
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
