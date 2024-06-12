import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //CREATE USER
  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //afeter create user , new doc create in firestore database
      firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({"uid": userCredential.user!.uid, "email": userCredential.user!.email, "isTyping": false});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //SIGNIN USER
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({"uid": userCredential.user!.uid, "email": userCredential.user!.email}, SetOptions(merge: true));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Log out
  Future<void> singOut() async {
    return await _auth.signOut();
  }

  updateTypingStatus(String uid, bool status) async {
    await firestore.collection("users").doc(uid).update({"isTyping": status});
  }
}
