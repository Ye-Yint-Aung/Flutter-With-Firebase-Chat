import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/widgets/message/message_list.dart';
import 'package:flutter_chat/presentation/widgets/message/message_textField.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({super.key, required this.userEmail, required this.userId, required this.currentUserId});

  final String userEmail;
  final String userId;
  final String currentUserId;

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

TextEditingController messageController = TextEditingController();

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userEmail ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 650,
                child: MessageListWidget(
                  userId: widget.userId,
                  userEmail: widget.userEmail,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<dynamic>(
                    stream: FirebaseFirestore.instance.collection("users").doc(widget.userId).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const SizedBox.shrink();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      }
                      return snapshot.data["isTyping"]
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: WidgetAnimator(
                                  atRestEffect: WidgetRestingEffects.pulse(),
                                  child: const Text(
                                    "Typing....",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  )),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  MessageTextField(
                    controller: messageController,
                    currentUserId: widget.currentUserId,
                    userId: widget.userId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
