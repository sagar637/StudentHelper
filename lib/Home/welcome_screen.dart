import 'package:flutter/material.dart';

import 'package:studenthelper/constanst/constantindex.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Helper'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.lightBlueAccent,
        ),
        backgroundColor: Colors.orange,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset("assets/images/1.jpg"),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () {
                    Navigator.pushNamed(context, 'getting_started');
                  },
                ),
                RoundedButton(
                    colour: Colors.blueAccent,
                    title: 'Register',
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
                    }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Created For Educational Purpose"),
                    ],
                  ),
                )
              ]),
        ));
  }
}
