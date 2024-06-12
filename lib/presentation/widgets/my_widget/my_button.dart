import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.btnName, required this.onTap});
  final String? btnName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            btnName ?? "",
            style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
