// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:flutter/material.dart';
// import 'package:studenthelper/Home/index.dart';
// import 'package:studenthelper/constanst/constantindex.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// final _auth = FirebaseAuth.instance;
//
// class _LoginScreenState extends State<LoginScreen> {
//   late String email;
//   late String password;
//   bool showSpinner = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ModalProgressHUD(
//         inAsyncCall: showSpinner,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) {
//                     email = value;
//                     //Do something with the user input.
//                   },
//                   decoration: kTextFieldDecoration.copyWith(
//                     hintText: 'Enter your email',
//                   )),
//               const SizedBox(
//                 height: 8.0,
//               ),
//               TextField(
//                   obscureText: true,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) {
//                     password = value;
//                     //Do something with the user input.
//                   },
//                   decoration: kTextFieldDecoration.copyWith(
//                       hintText: 'Enter your password.')),
//               const SizedBox(
//                 height: 24.0,
//               ),
//               RoundedButton(
//                   colour: Colors.lightBlueAccent,
//                   title: 'Log In',
//                   onPressed: () async {
//                     setState(() {
//                       showSpinner = true;
//                     });
//                     final user = await _auth
//                         .signInWithEmailAndPassword(
//                             email: email, password: password)
//                         .catchError((err) {
//                       //error msg
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Text("Error"),
//                               content: Text(err.message),
//                               actions: [
//                                 TextButton(
//                                   child: const Text("Ok"),
//                                   onPressed: () {
//                                     Navigator.pushNamed(
//                                         context, 'welcome_screen');
//                                   },
//                                 ),
//                               ],
//                             );
//                           });
//                     });
//                     try {
//                       final user = await _auth.signInWithEmailAndPassword(
//                           email: email, password: password);
//                       if (user != null) {
//                         Navigator.pushNamed(context, 'dashboard');
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                     setState(() {
//                       showSpinner = false;
//                     });
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studenthelper/Home/signup_screen.dart';

import '../Resources/auth_methos.dart';
import '../Utilis/screenvariable.dart';
import '../Utilis/utilis.dart';
import '../Widgets/text_field_input.dart';
import '../constanst/constants.dart';
import 'dashboard.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
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
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? const Text(
                    'Log in',
                  )
                      : const CircularProgressIndicator(
                    color: primaryColor,
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
                onTap: loginUser,
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
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
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' Signup.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}