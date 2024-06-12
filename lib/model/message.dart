import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  final bool isTyping;
  final String imageUrl;

  Message(
      {required this.senderId,
      required this.senderEmail,
      required this.recieverId,
      required this.message,
      required this.timestamp,
      required this.isTyping,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "recieverId": recieverId,
      "message": message,
      "timestamp": timestamp,
      "isTyping": isTyping,
      "imageUrl": imageUrl
    };
  }
}
