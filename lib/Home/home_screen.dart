import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studenthelper/Widgets/homecard.dart';

import '../Api/firebase_api.dart';
import '../Models/firebase_file.dart';
import '../Utilis/utilis.dart';
import '../Widgets/post_card.dart';

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(" Digital Notes"),
        backgroundColor: Colors.indigo
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('notes').snapshots(),
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
                  child: Homecard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
