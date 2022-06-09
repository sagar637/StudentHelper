import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Semester/semindex.dart';
import 'package:studenthelper/subject/subjectindex.dart';

import '../Widgets/homecard.dart';

class Course extends StatefulWidget { //yo semester page ho
  final snap;
  const Course({Key? key,  this.snap}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.snap!.length,
          itemBuilder: (ctx, index) => Container(
        // margin: EdgeInsets.symmetric(
        //   horizontal: width > webScreenSize ? width * 0.3 : 0,
        //   vertical: width > webScreenSize ? 15 : 0,
        // ),
       child:
          Card(
              child: ListTile(
                 title: Text(widget.snap[index]['name']),
                 subtitle: Text( widget.snap[index]['name'] + "BCIS Study Materials"),
                 leading: CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                 trailing: Icon(Icons.abc),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Subjectes(snap: widget.snap[index]['subject'],)));
                    //Navigator.pushNamed(context, 'bcis_sem1');
                 }
               ))

      )));




      // ListView(
      // child: Card(
      //     child: ListTile(
      //         title: Text(widget.snap['name']),
      //
      //         subtitle: Text(widget.snap['name'] + " Study Materials"),
      //         // leading: CircleAvatar(
      //         //     backgroundImage: AssetImage(widget.snap['image'])),
      //
      //         trailing: Icon(Icons.arrow_forward),
      //         onTap: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) =>
      //                       Course(snap: widget.snap['subject'],)));
      //
      //           // Navigator.push(context, MaterialPageRoute(builder: () => Course(snap:widget.snap['semester'])))
      //         })),
    //);
      // Scaffold(
      // appBar: AppBar(
      //   leading: null,
      //   actions: <Widget>[],
      //   title: const Text('BCIS'),
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      // body:
    //   ListView(
    //     padding: const EdgeInsets.all(8),
    //     children: <Widget>[
    //       Card(
    //           child: ListTile(
    //               title: Text("Semester I"),
    //               subtitle: Text("BCIS Study Materials"),
    //               leading:
    //                   CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
    //               trailing: Icon(Icons.arrow_forward))),
    //       // Card(
    //       //     child: ListTile(
    //       //         title: Text("Semester II"),
    //       //         subtitle: Text("BCIS Study Materials"),
    //       //         leading:
    //       //             CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
    //       //         trailing: Icon(Icons.arrow_forward))),
    //       Card(
    //           child: ListTile(
    //         title: Text("Semester III"),
    //         subtitle: Text("BCIS Study Materials"),
    //         leading: CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
    //         trailing: Icon(Icons.arrow_forward),
    //          onTap: () {
    //            Navigator.pushNamed(context, 'bcis_sem1');
    //         }
    //       )),
    //       Card(
    //           child: ListTile(
    //               title: Text("Semester IV"),
    //               subtitle: Text("BCIS Study Materials"),
    //               leading:
    //                   CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
    //               trailing: Icon(Icons.arrow_forward)))
    //     ],
    //   ),
    // );
  }
}


