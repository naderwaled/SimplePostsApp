import 'package:Task/Screens/AddPostPage.dart';
import 'package:flutter/material.dart';
import 'package:Task/Components/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  static String id = "Home_Screen";
  static int postcounter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Center(child: Text("TaskBook")),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FlatButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, AddPost.id);
                },
                child: Text(
                  "Add Post",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            GetPosts(),
          ],
        ),
      ),
    );
  }
}

class GetPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').get(),
        builder: (context, snapshot) {
          print('here');
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          HomePage.postcounter = 0;
          final posts = snapshot.data.docs.reversed;
          List<Post> postlist = [];
          for (var post in posts) {
            HomePage.postcounter += 1;
            final posttext = post.get('posttext');
            final username = post.get('username');
            final like = post.get('like');
            final comment = post.get('comments');
            print(posttext);
            print(username);
            List<String> comments = new List<String>.from(comment);
            print("Length: " + comments.length.toString());
            final postwidget = Post(
              id: post.id,
              postText: posttext,
              userName: username,
              comments: comments,
              like: like == 1 ? true : false,
            );
            postlist.add(postwidget);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: postlist,
            ),
          );
        });
  }
}
