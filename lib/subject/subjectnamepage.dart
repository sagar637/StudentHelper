import 'package:flutter/material.dart';
import '../NotesDownload/semester_pdf.dart';

class Subjectes extends StatefulWidget {   //Subject Names ko page
  final snap;
  const Subjectes({Key? key, this.snap}) : super(key: key);

  @override
  State<Subjectes> createState() => _SubjectesState();
}

class _SubjectesState extends State<Subjectes> {
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
                                        SemesterPDF(snap: widget.snap[index]['notes'],)));
                           // Navigator.pushNamed(context, 'bcis_sem1');
                          }
                      )),
                )

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