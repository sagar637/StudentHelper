import 'package:flutter/material.dart';
import 'package:studenthelper/Semester/semindex.dart';
import 'package:studenthelper/subject/subjectindex.dart';

class BCIS extends StatefulWidget {
  const BCIS({Key? key}) : super(key: key);

  @override
  State<BCIS> createState() => _BCISState();
}

class _BCISState extends State<BCIS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[],
        title: const Text('BCIS'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
              child: ListTile(
                  title: Text("Semester I"),
                  subtitle: Text("BCIS Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward))),
          Card(
              child: ListTile(
                  title: Text("Semester II"),
                  subtitle: Text("BCIS Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward))),
          Card(
              child: ListTile(
            title: Text("Semester III"),
            subtitle: Text("BCIS Study Materials"),
            leading: CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
            trailing: Icon(Icons.arrow_forward),
             onTap: () {
               Navigator.pushNamed(context, 'bcis_sem1');
            }
          )),
          Card(
              child: ListTile(
                  title: Text("Semester IV"),
                  subtitle: Text("BCIS Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward)))
        ],
      ),
    );
  }
}
