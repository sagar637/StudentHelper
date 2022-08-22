import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studenthelper/Home/seasomuipage/forgotpassword.dart';
import 'package:studenthelper/Home/seasomuipage/siugnup.dart';
import 'package:studenthelper/constanst/constants.dart';

import '../../Resources/auth_methos.dart';
import '../../Utilis/utilis.dart';
import '../../Widgets/text_field_input.dart';
import '../dashboard.dart';
import '../signup_screen.dart';

class Slogin extends StatefulWidget {
  Slogin({Key? key}) : super(key: key);

  @override
  State<Slogin> createState() => _SloginState();
}

class _SloginState extends State<Slogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                          TextFieldInput(
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
                            hintText: "Enter your email",
                            textInputType: TextInputType.emailAddress,
                            textEditingController: _emailController,
                          ),
                          SizedBox(height: 16,),
                          TextFieldInput(
                            // decoration: InputDecoration(
                            //     border: InputBorder.none,
                            //     hintText: "Password",
                            //     hintStyle: TextStyle(color: Colors.grey[400])
                            // ),
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            textEditingController: _passwordController,
                            isPass: true,
                          ),
                          SizedBox(height: 30,),
                          Container(
                            height: 50,
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
                             child:InkWell(
                              child: Container(
                                child: !_isLoading
                                    ? const Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                )
                                    : const CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 2,
                                ),
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 8), // change login button UI
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                  ),
                                ),
                              ),
                              onTap: loginUser,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: const Text(
                                  'Dont have an account?',
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                ),
                                child: Container(
                                  child: const Text(  // Create Forget password page and do it with firebase authorization
                                    ' Signup.',   // Get email veriication using firebase
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        ),
                        child: Text("Forgot Password?", style: TextStyle(color:  Color.fromRGBO(143, 148, 251, 2),) ),
                      ),

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