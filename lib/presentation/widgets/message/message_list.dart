import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../service/chat_service.dart';
import 'message_item.dart';

class MessageListWidget extends StatelessWidget {
  const MessageListWidget({super.key, required this.userId, required this.userEmail});

  final String userId;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ChatService();
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: chatService.getMessage(userId, auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error..."),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: snapshot.data!.docs
                .map((document) => MessageItemWidget(document: document, userEmail: userEmail))
                .toList(),
          ),
        );
      },
    );
  }
}
