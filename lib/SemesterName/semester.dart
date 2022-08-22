
import 'package:flutter/material.dart';
import 'package:studenthelper/subject/subjectindex.dart';



class Semester extends StatefulWidget { //yo semester page ho
  final snap;
  const Semester({Key? key,  this.snap}) : super(key: key);

  @override
  State<Semester> createState() => _SemesterState();
}

class _SemesterState extends State<Semester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(" Digital Notes"),
            backgroundColor: Colors.black,
        ),
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
                 leading: CircleAvatar(backgroundImage: AssetImage("assets/1.png")),
                 trailing: Icon(Icons.abc),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Subjectes(snap: widget.snap[index]['subject'],)));

                 }
               ))

      )));
  }
}


