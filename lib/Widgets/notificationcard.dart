


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Community/Feed/feedmain.dart';

import '../Modelss/user.dart';
import '../Resources/auth_methos.dart';
import '../Utilis/utilis.dart';

class NotificationCard extends StatefulWidget {
  final snap;
   const NotificationCard({Key? key, this.snap}) : super(key: key);
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}
class _NotificationCardState extends State<NotificationCard> {
  int commentLen = 0;
  // bool isLikeAnimating = false;
  User? user;
  //
  @override
  void initState() {
    super.initState();
    postUserDispay();
    fetchCommentLen();
  }
  postUserDispay() async {
    User _user = await AuthMethods().getUserDetails();
    setState(() {
      user = _user;
    });
  }
  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(
              widget.snap['username'] + 'Posted a Question',
                 //' ${user!.username}'
            ),
            subtitle: Text('${widget.snap['likes'].length} likes' '$commentLen comments'
            ),
            leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.snap['profImage'])),
            // trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FeedScreen(
                     // uid: (snapshot.data! as dynamic).docs[index]['uid'],
                    ),
                  ));
    })
    );
  }
}

