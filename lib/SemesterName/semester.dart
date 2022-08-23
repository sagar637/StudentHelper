
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
          backgroundColor: Color.fromRGBO(143, 148, 251, 2),
        ),

      body: ListView.builder(
          itemCount: widget.snap!.length,
          itemBuilder: (ctx, index) => Container(
        // margin: EdgeInsets.symmetric(
        //   horizontal: width > webScreenSize ? width * 0.3 : 0,
        //   vertical: width > webScreenSize ? 15 : 0,
        // ),
       child:
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, 2),
                      blurRadius: 4.0,
                      offset: Offset(0, 5)
                  )
                ]
            ),
            child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Color.fromRGBO(143, 148, 251, 2),
                child: ListTile(
                   title: Text(widget.snap[index]['name']),
                   subtitle: Text( widget.snap[index]['name'] + "BCIS Study Materials"),
                   leading: CircleAvatar(backgroundImage: AssetImage("assets/1.png")),
                   trailing: Icon(Icons.note_sharp),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Subjectes(snap: widget.snap[index]['subject'],)));

                   }
                 )),
          )

      )));
  }
}


