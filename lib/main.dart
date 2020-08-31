import 'package:Task/Screens/AddPostPage.dart';
import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print('Complete'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        AddPost.id: (context) => AddPost(),
      },
    );
  }
}
