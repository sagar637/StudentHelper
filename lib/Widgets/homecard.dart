import 'package:flutter/material.dart';


import '../SemesterName/semester.dart';

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
              // trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Semester(snap: widget.snap['semester'],)));

                // Navigator.push(context, MaterialPageRoute(builder: () => Course(snap:widget.snap['semester'])))
              })),
    );
  }
}
