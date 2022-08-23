import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studenthelper/Community/chat/chat.dart';

import '../../Utilis/screenvariable.dart';
import '../../Widgets/post_card.dart';
import '../../constanst/constants.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: width > webScreenSize
      //     ? null
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        title: Text("Feed"),
        backgroundColor:
            Color.fromRGBO(143, 148, 251, 2), // add logo in this page at appBar
        // title: SvgPicture.asset(
        //   'assets/ic_instagram.svg',
        //   color: primaryColor,
        //   height: 32,
        // ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'chat');
            },
          ),
        ],
      ),
      body: StreamBuilder(
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
              // margin: EdgeInsets.symmetric(
              //   horizontal: width > webScreenSize ? width * 0.3 : 0,
              //   vertical: width > webScreenSize ? 15 : 0,
              // ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
