import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studenthelper/Home/seasomuipage/slogin.dart';

import '../../Resources/auth_methos.dart';
import '../../Utilis/utilis.dart';
import '../../Widgets/text_field_input.dart';
import '../../constanst/constants.dart';
import '../dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MobileScreenLayout(),
        ),

      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // bool _isLoading = false;
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  // }
  //
  // void registerUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String res = await AuthMethods().loginUser(
  //       email: _emailController.text, password: _passwordController.text);
  //   if (res == 'success') {
  //     Navigator.of(context).push(
  //       MaterialPageRoute( builder: (context) => const
  //       MobileScreenLayout(),
  //
  //       ),
  //     );
  //         (route) => false;
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     showSnackBar(context, res);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 30,
                        width: 80,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        )),
                    Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        )),
                    Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        )),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text(
                            "Digital Notes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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
                          Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Colors.red,
                              )
                                  : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                                backgroundColor: Colors.red,
                              ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16,),
                          TextFieldInput(  // change UI
                            hintText: 'Enter your username',
                            textInputType: TextInputType.text,
                            textEditingController: _usernameController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            hintText: 'Enter your email',
                            textInputType: TextInputType.emailAddress,
                            textEditingController: _emailController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            textEditingController: _passwordController,
                            isPass: true,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            hintText: 'Enter your bio',
                            textInputType: TextInputType.text,
                            textEditingController: _bioController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          // TextFieldInput(
                          //   // decoration: InputDecoration(
                          //   //   textInputType: TextInputType.emailAddress,
                          //   //   textEditingController: _emailController,
                          //   //   border: InputBorder.none,
                          //   //   hintText: "Email or Gmail account",
                          //   //
                          //   //   hintStyle: TextStyle(color: Colors.grey[400]),
                          //   //
                          //   //
                          //   //
                          //   // ),
                          //   hintText: "Username",
                          //   textInputType: TextInputType.emailAddress,
                          //   textEditingController: _emailController,
                          // ),
                          // SizedBox(height: 16,),
                          // TextFieldInput(
                          //   // decoration: InputDecoration(
                          //   //     border: InputBorder.none,
                          //   //     hintText: "Password",
                          //   //     hintStyle: TextStyle(color: Colors.grey[400])
                          //   // ),
                          //   hintText: 'Email Address',
                          //   textInputType: TextInputType.text,
                          //   textEditingController: _passwordController,
                          //   isPass: true,
                          // ),
                          // SizedBox(height: 16,),
                          // TextFieldInput(
                          //   // decoration: InputDecoration(
                          //   //     border: InputBorder.none,
                          //   //     hintText: "Password",
                          //   //     hintStyle: TextStyle(color: Colors.grey[400])
                          //   // ),
                          //   hintText: 'Password',
                          //   textInputType: TextInputType.text,
                          //   textEditingController: _passwordController,
                          //   isPass: true,
                          // ),
                          // SizedBox(height: 16,),
                          // TextFieldInput(
                          //   // decoration: InputDecoration(
                          //   //     border: InputBorder.none,
                          //   //     hintText: "Password",
                          //   //     hintStyle: TextStyle(color: Colors.grey[400])
                          //   // ),
                          //   hintText: 'Confirm password',
                          //   textInputType: TextInputType.text,
                          //   textEditingController: _passwordController,
                          //   isPass: true,
                          // ),
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
                        child:InkWell(
                          child: Container(
                            child: !_isLoading
                                ? const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            )
                                : const CircularProgressIndicator(
                              color: primaryColor,
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
                          onTap: signUpUser,
                        ),

                      ),
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
                          // SizedBox(height: 70,),
                          // Text("Forgot Password?", style: TextStyle(color:  Color.fromRGBO(143, 148, 251, 2),) ),

                        ],
                      ),
              )

                        ],
                      ),
                    )
                  ],
                ),
              )
    //         ],
    //       ),
    //     ),
    //   ),
      )
    );
  }
}
