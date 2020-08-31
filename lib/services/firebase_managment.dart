import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:Task/Screens/HomePage.dart';

final _firestore = FirebaseFirestore.instance;

class FirebaseManagment {
  static void uploadFile(String folder, File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$folder/${HomePage.postcounter}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
  }

  static void addpost(String username, String posttext, File profileimage,
      File postimage) async {
    await _firestore.collection("posts").doc('${HomePage.postcounter}').set({
      'username': username,
      'posttext': posttext,
      'like': 0,
      'comments': [],
    });
    uploadFile("ProfileImages", profileimage);
    uploadFile("PostImages", postimage);
  }

  static void updatelikestate(bool pushlike, String id) {
    FirebaseFirestore.instance.collection("posts").doc(id).update({
      'like': pushlike ? 1 : 0,
    });
  }

  static void addcomment(List<String> allcomments, String id) {
    FirebaseFirestore.instance.collection("posts").doc(id).update({
      'comments': allcomments,
    });
  }

  static Future<String> getImage(String id, String folder, String image) async {
    print(id);
    String s = await FirebaseStorage.instance
        .ref()
        .child('$folder/$image.jpg')
        .getDownloadURL();
    print(s.toString());
    return s.toString();
  }
}
