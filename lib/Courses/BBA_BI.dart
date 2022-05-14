import 'package:flutter/material.dart';
import 'package:studenthelper/Semester/semindex.dart';

class BBABI extends StatefulWidget {
  const BBABI({Key? key}) : super(key: key);

  @override
  State<BBABI> createState() => _BBABIState();
}

class _BBABIState extends State<BBABI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[],
        title: const Text('Home Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
              child: ListTile(
                  title: Text("Semester I"),
                  subtitle: Text("BBA Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward))),
          Card(
              child: ListTile(
                  title: Text("Semester II"),
                  subtitle: Text("BBA Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward))),
          Card(
              child: ListTile(
                  title: Text("Semester III"),
                  subtitle: Text("BBA Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, 'bcis_sem');
                  })),
          Card(
              child: ListTile(
                  title: Text("Semester IV"),
                  subtitle: Text("BBA Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward)))
        ],
      ),
    );
  }
}
