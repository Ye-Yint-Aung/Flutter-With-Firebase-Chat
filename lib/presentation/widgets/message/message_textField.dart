import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/chat_service.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({super.key, required this.controller, required this.currentUserId, required this.userId});

  final TextEditingController controller;
  final String currentUserId;
  final String userId;

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ChatService();
    CollectionReference _reference = FirebaseFirestore.instance.collection("image");
    String imageUrl = "";

    /// TYPING STATUS
    void updateTypingStatus(bool status) {
      chatService.updateTypingStatus(status, widget.currentUserId);
    }

    /// SEND MESSAGE
    void sendMessage(String imageUrl) async {
      if (imageUrl.isNotEmpty) {
        if (widget.controller.text.isEmpty) {
          await chatService.sendMessage(widget.userId, "", imageUrl);
          widget.controller.clear();
          updateTypingStatus(false);
        }
      } else {
        if (widget.controller.text.isNotEmpty) {
          await chatService.sendMessage(widget.userId, widget.controller.text, "");
          widget.controller.clear();
          updateTypingStatus(false);
        }
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (_) {
                updateTypingStatus(true);
              },
              onTapOutside: (_) {
                updateTypingStatus(false);
              },
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(imageUrl);
                  },
                ),
                border: const OutlineInputBorder(),
                labelText: "Text",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () async {
              final ImagePicker picker0 = ImagePicker();
              XFile? file = await picker0.pickImage(source: ImageSource.gallery);
              // print("I am image name is : ${file?.path}");

              if (file == null) return;

              String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

              ///
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImage = referenceRoot.child("Image");

              //Create a reference for the image to the store
              Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

              //Store the file
              try {
                await referenceImageToUpload.putFile(File(file.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
                sendMessage(imageUrl);
              } catch (error) {
                // Do Something
                print(error.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
