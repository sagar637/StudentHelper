import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Courses/course.dart';

import '../Modelss/user.dart';
import '../Resources/auth_methos.dart';
import '../Utilis/utilis.dart';

class Homecard extends StatefulWidget {
  final snap;
  const Homecard({Key? key, this.snap}) : super(key: key);

  @override
  State<Homecard> createState() => _HomecardState();
}

class _HomecardState extends State<Homecard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: ListTile(
              title: Text(widget.snap['course']),
              subtitle: Text(widget.snap['course'] + " Study Materials"),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['image'])),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Course(snap: widget.snap['semester'],)));

                // Navigator.push(context, MaterialPageRoute(builder: () => Course(snap:widget.snap['semester'])))
              })),
    );
  }
}
