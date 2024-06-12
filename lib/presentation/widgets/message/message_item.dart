import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({super.key, required this.document, required this.userEmail});

  final DocumentSnapshot document;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data["senderId"] == auth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
    var crossAlign = (data["senderId"] == auth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start;
    var imageAlign = (data["senderId"] == auth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    var margin = (data["senderId"] == auth.currentUser!.uid) ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: imageAlign,
        children: [
          Container(
              color: Colors.red,
              margin: margin,
              child: (data["imageUrl"].toString().isNotEmpty)
                  ? Image.network(
                      fit: BoxFit.cover,
                      data["imageUrl"].toString(),
                      height: 200,
                    )
                  : SizedBox.shrink()),
          Row(
            mainAxisAlignment: crossAlign,
            children: [
              (data["senderId"] == auth.currentUser!.uid)
                  ? Container()
                  : CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Center(
                        child: Text(userEmail.toString().substring(0, 1).toUpperCase()),
                      ),
                    ),
              Flexible(
                  child: (data["message"].toString().isNotEmpty)
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          margin: margin,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.white)),
                          child: Text(
                            data["message"],
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ))
                      : SizedBox.shrink()),
              (data["senderId"] == auth.currentUser!.uid)
                  ? CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Text(auth.currentUser!.email.toString().substring(0, 1).toUpperCase()),
                      ),
                    )
                  : Container(),
              // CircleAvatar(),
            ],
          ),
        ],
      ),
    );
  }
}
