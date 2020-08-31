import 'package:Task/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:Task/Screens/HomePage.dart';
import 'package:Task/services/firebase_managment.dart';

class AddPost extends StatefulWidget {
  static String id = 'Add_Post_Screen';

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool _getprofileimage = false;
  bool _getpostimage = false;
  File _postimage;
  File _profileimage;
  TextEditingController _username = TextEditingController();
  TextEditingController _posttext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _username,
              decoration: kPostdecoration.copyWith(hintText: 'Enter UserName'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _posttext,
              decoration: kPostdecoration.copyWith(hintText: 'Enter Post Text'),
            ),
            FlatButton(
              onPressed: () async {
                if (!_getprofileimage) {
                  _profileimage = await chooseFile();
                  _getprofileimage = true;
                } else {
                  _getprofileimage = false;
                }
              },
              child: Text(_getprofileimage == true
                  ? "Cancel profile image"
                  : "Add profile image"),
              color: Colors.grey.shade300,
            ),
            FlatButton(
              onPressed: () async {
                if (!_getpostimage) {
                  _postimage = await chooseFile();
                  _getpostimage = true;
                } else {
                  _getpostimage = false;
                }
              },
              child:
                  Text(_getpostimage ? "Cancel post photo" : "Add Post photo"),
              color: Colors.grey.shade300,
            ),
            FlatButton(
              onPressed: () {
                HomePage.postcounter += 1;
                FirebaseManagment.addpost(
                    _username.text, _posttext.text, _profileimage, _postimage);
                Navigator.pop(context);
              },
              child: Text('Save post'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Future chooseFile() async {
    File image;
    final PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
    });
    return image;
  }
}
