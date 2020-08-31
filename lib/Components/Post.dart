import 'package:Task/Components/comment.dart';
import 'package:flutter/material.dart';
import 'package:Task/constant.dart';
import 'package:Task/services/firebase_managment.dart';

class Post extends StatelessWidget {
  const Post({this.id, this.postText, this.userName, this.comments, this.like});
  final String id;
  final bool like;
  final String userName;
  final String postText;

  final List<String> comments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: FirebaseManagment.getImage(id, 'ProfileImages', id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data),
                        );

                      if (snapshot.connectionState == ConnectionState.waiting)
                        return CircleAvatar();

                      return Container();
                    },
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(postText),
              SizedBox(
                height: 6.0,
              ),
              FutureBuilder(
                future: FirebaseManagment.getImage(id, 'PostImages', id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Container(
                      child: Image.network(snapshot.data),
                    );

                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Container(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ));

                  return Container();
                },
              ),
              LikeComment(
                id: id,
                like: like,
                comments: comments,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LikeComment extends StatefulWidget {
  LikeComment({this.id, this.like, this.comments});
  final id;
  final bool like;
  final List<String> comments;
  @override
  _LikeCommentState createState() => _LikeCommentState();
}

class _LikeCommentState extends State<LikeComment> {
  bool pushlike = false;
  bool pushcomment = false;
  List<String> allcomments = [];
  TextEditingController commentcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    pushlike = widget.like;
    allcomments = List.from(widget.comments);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      pushlike = pushlike == true ? false : true;
                      FirebaseManagment.updatelikestate(pushlike, widget.id);
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: pushlike ? Colors.red : Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      pushcomment = pushcomment == true ? false : true;
                    });
                  },
                  child: Icon(
                    Icons.comment,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          if (pushcomment)
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    textAlign: TextAlign.start,
                    controller: commentcontroller,
                    decoration:
                        kInputdecoration.copyWith(hintText: "Write Comment"),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        if (commentcontroller.text != '') {
                          allcomments.add(commentcontroller.text);
                          commentcontroller.text = '';
                          FirebaseManagment.addcomment(allcomments, widget.id);
                        }
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          if (pushcomment)
            GetComments(
              comments: allcomments,
            ),
        ],
      ),
    );
  }
}

class GetComments extends StatelessWidget {
  GetComments({this.comments});
  final List<String> comments;
  @override
  Widget build(BuildContext context) {
    List<Comment> commentlist = [];
    for (int i = 0; i < comments.length; i++) {
      final comment = Comment(
        userImage: 'images/Nader Waled.jpg',
        userName: 'defult user',
        comment: comments[i],
      );
      commentlist.add(comment);
    }
    return SizedBox(
      height: 60.0 * commentlist.length,
      child: ListView(
        children: commentlist.toList(),
      ),
    );
  }
}
