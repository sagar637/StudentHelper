
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthelper/Community/Feed/feedmain.dart';
import '../Resources/auth_methos.dart';
import '../Utilis/utilis.dart';

class NotificationCard extends StatefulWidget {
  final snap;
  final String uid;
    NotificationCard({Key? key, this.snap, required this.uid}) : super(key: key);
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}
class _NotificationCardState extends State<NotificationCard> {
  int commentLen = 0;
  User? user;
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // postUserDispay();
    DisplayCommentLen();
  }
  // postUserDispay() async {
  //   User _user = await AuthMethods().getUserDetails();
  //   setState(() {
  //     user = _user;
  //   });
  // }
  DisplayCommentLen() async {
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
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
               // userData['username'].toString()
                widget.snap['username']
                    + 'Posted a Question on',
                  // ' ${user!.username}'
              ),
            ),
            subtitle: Text( DateFormat.yMMMd()
                .format(widget.snap['datePublished'].toDate()),
                //'${widget.snap['likes'].length} likes' '$commentLen comments'
            ),
            leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    widget.snap['profImage']
                )),
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

