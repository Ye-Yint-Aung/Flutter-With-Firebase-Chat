import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/welcome/welcome.dart';

import '../../service/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            child: Text("Y"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("LogOut"),
              onTap: () {
                AuthService authService = AuthService();
                authService.singOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const WelcomePage()), (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(color: Colors.red, border: Border.all(width: 5.5)),
    );
  }
}
