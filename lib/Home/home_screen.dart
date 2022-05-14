import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),
        ],
        title: const Text('Home Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
              child: ListTile(
                  title: Text("BCIS"),
                  subtitle: Text("BCIS Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, 'BCIS');
                  })),
          Card(
              child: ListTile(
                  title: Text("BBA"),
                  subtitle: Text("BBA Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward))),
          Card(
              child: ListTile(
            title: Text("BBA-BI"),
            subtitle: Text("BBA-BI Study Materials"),
            leading: CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
            trailing: Icon(Icons.arrow_forward),
            // onTap: () {
            //   Navigator.pushNamed(context, 'BBA_BI');
            // }
          )),
          Card(
              child: ListTile(
                  title: Text("MBA"),
                  subtitle: Text("MBA Study Materials"),
                  leading:
                      CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
                  trailing: Icon(Icons.arrow_forward)))
        ],
      ),
    );
  }
}
