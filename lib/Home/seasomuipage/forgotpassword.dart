import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Home/login_screen.dart';
import 'package:studenthelper/Home/seasomuipage/forgotpassword.dart';
import 'package:studenthelper/Home/seasomuipage/siugnup.dart';
import 'package:studenthelper/Home/seasomuipage/slogin.dart';
import 'package:studenthelper/constanst/constants.dart';

import '../../Resources/auth_methos.dart';
import '../../Utilis/utilis.dart';
import '../../Widgets/text_field_input.dart';
import '../dashboard.dart';
import '../signup_screen.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final auth = FirebaseAuth.instance;
  String ? _email;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).push(
        MaterialPageRoute( builder: (context) => const
        MobileScreenLayout(),

        ),
      );
          (route) => false;

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Container(
                height: 300,
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
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            // decoration: InputDecoration(
                            //   textInputType: TextInputType.emailAddress,
                            //   textEditingController: _emailController,
                            //   border: InputBorder.none,
                            //   hintText: "Email or Gmail account",
                            //
                            //   hintStyle: TextStyle(color: Colors.grey[400]),
                            //
                            //
                            //
                            // ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email link'

                            ),
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            }
                            // hintText: "Email or Gmail account",
                            // textInputType: TextInputType.emailAddress,
                            // textEditingController: _emailController,

    ),
                          SizedBox(height: 30,),
                          Container(
                            height: 50,
                            // padding:const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(143, 148, 251, 2),
                                      Color.fromRGBO(143, 148, 251, 2),
                                    ]
                                )
                            ),
                            // child: Center(
                            //   child: Text(
                            //     "Login" ,
                            //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            //   ),
                            //
                            // ),
                            child : TextButton(

                             // color: Color.fromRGBO(143, 148, 251, 2),
                              child : Text( " Send Email" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              onPressed: () {
                                auth.sendPasswordResetEmail(email: _email!);
                                Navigator.of(context).pop();
                              },
                            )
                            // child:InkWell(
                            //   child: Container(
                            //     child: !_isLoading
                            //         ? const Text(
                            //       'Send Email',
                            //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            //     )
                            //         : const CircularProgressIndicator(
                            //       color: primaryColor,
                            //     ),
                            //     width: double.infinity,
                            //     alignment: Alignment.center,
                            //     padding: const EdgeInsets.symmetric(vertical: 8), // change login button UI
                            //     decoration: const ShapeDecoration(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.all(Radius.circular(4)),
                            //       ),
                            //     ),
                            //   ),
                            //   // onTap: LoginScreen,
                            // ),
                          ),
                          // SizedBox(height: 8,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       child: const Text(
                          //         'Dont have an account?',
                          //       ),
                          //       padding: const EdgeInsets.symmetric(vertical: 8),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () => Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //           builder: (context) => const SignUp(),
                          //         ),
                          //       ),
                          //       child: Container(
                          //         child: const Text(  // Create Forget password page and do it with firebase authorization
                          //           ' Signup.',   // Get email veriication using firebase
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //         padding: const EdgeInsets.symmetric(vertical: 8),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 50,),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: const Text(
                                  'Already have an account?',
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Slogin(),
                                  ),
                                ),
                                child: Container(
                                  child: const Text(  // Create Forget password page and do it with firebase authorization
                                    ' Login.',   // Get email veriication using firebase
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ],
                          ),
                          // GestureDetector(
                          //   onTap: () => Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Slogin(),
                          //     ),
                          //   ),
                          //   child: Text("Already have a account? Login", style: TextStyle(color:  Color.fromRGBO(143, 148, 251, 2),) ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}