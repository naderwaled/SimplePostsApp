import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  Comment({this.userImage, this.userName, this.comment});
  final String userImage;
  final String userName;
  final String comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(userImage),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      comment,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
