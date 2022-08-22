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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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

            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  }),
            )),
      ),
    );
  }
}
