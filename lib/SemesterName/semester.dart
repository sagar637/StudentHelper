import 'package:flutter/material.dart';
import 'package:studenthelper/subject/subjectindex.dart';

class Semester extends StatefulWidget {
  //yo semester page ho
  final snap;
  const Semester({Key? key, this.snap}) : super(key: key);

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
            backgroundColor: Colors.indigo),
        body: ListView.builder(
            itemCount: widget.snap!.length,
            itemBuilder: (ctx, index) => Container(
                    child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.indigo, Colors.blue]),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4.0,
                            offset: Offset(0, 5))
                      ]),
                  child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: Colors.transparent,
                      // color: Color.fromRGBO(143, 148, 251, 2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                              title: Text(
                                widget.snap[index]['name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              subtitle: Text(
                                widget.snap[index]['name'] + " Study Materials",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0),
                              ),
                              leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/1.png"),
                                  backgroundColor: Colors.transparent),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 15.0),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Subjectes(
                                              snap: widget.snap[index]
                                                  ['subject'],
                                            )));
                              }),
                        ),
                      )),
                ))));
  }
}
