
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Modelss/user.dart';
import '../../Resources/auth_methos.dart';
import '../../Utilis/utilis.dart';
import '../../Widgets/notificationcard.dart';

class Notifaction extends StatefulWidget {
  final snap;
  User? loggedinUser;
   Notifaction({Key? key , this.snap}) : super(key: key);

  @override
  State<Notifaction> createState() => _NotifactionState();
}

class _NotifactionState extends State<Notifaction> {
  //  int commentLen = 0;
  // // bool isLikeAnimating = false;
  // User? user;
  //
  @override
  void initState() {
    super.initState();

  }
  //
  // postUserDispay() async {
  //   User _user = await AuthMethods().getUserDetails();
  //   setState(() {
  //     user = _user;
  //   });
  // }
  // fetchCommentLen() async {
  //   try {
  //     QuerySnapshot snap = await FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc(widget.snap['postId'])
  //         .collection('likes')
  //         .get();
  //     commentLen = snap.docs.length;
  //   } catch (err) {
  //     showSnackBar(
  //       context,
  //       err.toString(),
  //     );
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(" Digital "),
          backgroundColor: Colors.black,
        ),
        body:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(

                child:

                NotificationCard(
                  snap: snapshot.data!.docs[index].data(), uid: 'snapshot.data!.docs[index].data()',

                ),

              ),
            );
          },
        ),
    );
  }
}

