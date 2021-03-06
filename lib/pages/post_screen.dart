import 'package:flutter/material.dart';
import 'package:pondergram/pages/home.dart';
import 'package:pondergram/pages/post.dart';
import 'package:pondergram/widgets/loading.dart';
import 'package:pondergram/widgets/reusable_header.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;

  PostScreen({this.postId, this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef.doc(userId).collection('userPosts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return circularProgress();
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: header(context, title: post.caption.toUpperCase()),
              body: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: post,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
