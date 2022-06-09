import 'package:flutter/material.dart';
import 'package:studenthelper/subjectfiles/semester_pdf.dart';

class Subjectes extends StatefulWidget {  //Subject Names ko page
  final snap;
  const Subjectes({Key? key, this.snap}) : super(key: key);

  @override
  State<Subjectes> createState() => _SubjectesState();
}

class _SubjectesState extends State<Subjectes> {
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
                        trailing: Icon(Icons.precision_manufacturing),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SemesterPDF(snap: widget.snap[index]['notes'],)));
                         // Navigator.pushNamed(context, 'bcis_sem1');
                        }
                    ))

            )));
  // Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(" Choose Your Subject"),
    //   ),
    //   body: ListView(
    //     children: <Widget>[

          // Card(
          //     child: ListTile(
          //         title: Text("Subject Name(Principle of mannagementm)"),
          //         subtitle: Text("BCIS Study Materials"),
          //         //leading:
          //         //  CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
          //         trailing: Icon(Icons.arrow_forward),
          //         onTap: () {
          //           Navigator.pushNamed(context, 'semester_pdf');
          //         })),
  //       ],
  //     ),
  //   );
  // }
}
}