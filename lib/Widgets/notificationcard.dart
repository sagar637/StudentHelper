
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(

          leading : CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.snap['profImage']
                    ),
            radius: 25,
          ),
              contentPadding: EdgeInsets.all(0),
                title: Text(

                    widget.snap['username']
                      + 'Posted a Question on',
                ),
                trailing: Text( DateFormat.yMMMd()
                 .format(widget.snap['datePublished'].toDate()),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              // title: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //    // userData['username'].toString()
              //     widget.snap['username']
              //         + 'Posted a Question on',
              //       // ' ${user!.username}'
              //   ),
              // ),
              // subtitle: Text(
              // DateFormat.yMMMd()
              //     .format(widget.snap['datePublished'].toDate()),
              //     //'${widget.snap['likes'].length} likes' '$commentLen comments'
              // ),
              // leading: CircleAvatar(
              //     backgroundImage: NetworkImage(
              //         widget.snap['profImage']
              //     )),
              // trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FeedScreen(
                        // uid: (snapshot.data! as dynamic).docs[index]['uid'],
                      ),
                    ));
    }),
        )
    );

  }
}
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
//
// class Notifications extends StatefulWidget {
//   final snap;
//   final String uid;
//     Notifications({Key? key, this.snap, required this.uid}) : super(key: key);
//   @override
//   _NotificationsState createState() => _NotificationsState();
// }
//
// class _NotificationsState extends State<Notifications> {
//
//   @override
//   Widget build(BuildContext context) {
//     var snapshot;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Notifications",
//         ),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.filter_list,
//             ),
//             onPressed: (){},
//           ),
//         ],
//       ),
//
//       body: ListView.separated(
//         padding: EdgeInsets.all(10),
//         separatorBuilder: (BuildContext context, int index) {
//           return Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               height: 0.5,
//               width: MediaQuery.of(context).size.width / 1.3,
//               child: Divider(),
//             ),
//           );
//         },
//         itemCount: snapshot.data!.docs.length,
//         itemBuilder: (BuildContext context, int index) {
//
//
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               leading : CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       widget.snap['profImage']
//                   )),
//
//               contentPadding: EdgeInsets.all(0),
//               title: Text(
//
//                   widget.snap['username']
//                     + 'Posted a Question on',
//               ),
//               trailing: Text( DateFormat.yMMMd()
//                .format(widget.snap['datePublished'].toDate()),
//                 style: TextStyle(
//                   fontWeight: FontWeight.w300,
//                   fontSize: 11,
//                 ),
//               ),
//               onTap: (){},
//             ),
//           );
//         },
//
//       ),
//     );
//   }
// }

