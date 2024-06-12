import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../chat/chat_detail.dart';

class UserListItemWidget extends StatelessWidget {
  const UserListItemWidget({super.key, required this.document});

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (auth.currentUser!.email != data["email"]) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Center(
            child: Text(data["email"].toString().substring(0, 1).toUpperCase()),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${data["email"]}"),
            data["isTyping"]
                ? WidgetAnimator(
                    atRestEffect: WidgetRestingEffects.pulse(),
                    child: const Text(
                      "Typing....",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ))
                : const Text(""),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetail(
                      userEmail: data["email"],
                      userId: data["uid"],
                      currentUserId: auth.currentUser!.uid.toString(),
                    )),
          );
        },
      );
    } else {
      return Container();
      //return empty();
    }
  }
}
