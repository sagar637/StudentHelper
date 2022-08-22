import 'package:flutter/material.dart';
import 'package:studenthelper/Home/index.dart';
import 'package:studenthelper/Home/seasomuipage/slogin.dart';

class GettingStarted extends StatefulWidget {
  GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
            //
            Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill

                  )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 30,
                      width: 80,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-1.png')
                            )
                        ),
                      )
                  ),
                  Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-2.png')
                            )
                        ),
                      )
                  ),
                  Positioned(
                      right: 40,
                      top:40,
                      width: 80,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png')
                            )
                        ),
                      )
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          "Digital Notes",
                          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                      ),
                    ),

                  )
                ],
              ),
            ),
            //   Container(
            //   child: Text('Get your college notes digitally', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,),
            // ),
            Container(
                child: Image.asset('assets/images/notes_logo.png', width: 100, height: 100,),
              ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text('Digital Notes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  ),
                ),
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                    children: <Widget>[
                Container(
                padding: EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Color.fromRGBO(143, 148, 251, 2),
                //           blurRadius: 20.0,
                //           offset: Offset(0, 10)
                //
                //       )
                //     ]
                // ),
              //   SizedBox(height: 100,),
              // Container(
              //   child: Image.asset('assets/images/background.png', width: 100, height: 200,),
              // ),
              // Container(
              //   child: Text('Digital Notes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              // ),
              // Container(
              //   child: Text('Get your college notes digitally', style: TextStyle(fontSize: 16),),
              // ),
             child: Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Slogin())
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10, ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(143, 148, 251, 2),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Get Started', style: TextStyle(fontSize: 22, color: Colors.white),)),
                ),
              ),
               // SizedBox(height: 100,),
    )]),
        ),
                Text("Version 1.0")
      ]),
          ),

    )));
  }
}
      
  
  
