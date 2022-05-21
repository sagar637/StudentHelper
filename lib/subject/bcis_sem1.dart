import 'package:flutter/material.dart';
import 'package:studenthelper/subjectfiles/semester_pdf.dart';

class BCISSEMI extends StatefulWidget {
  const BCISSEMI({Key? key}) : super(key: key);

  @override
  State<BCISSEMI> createState() => _BCISSEMIState();
}

class _BCISSEMIState extends State<BCISSEMI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Choose Your Subject"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
              child: ListTile(
                  title: Text("Subject Name(Principle of mannagementm)"),
                  subtitle: Text("BCIS Study Materials"),
                  //leading:
                  //  CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, 'semester_pdf');
                  })),
        ],
      ),
    );
  }
}
