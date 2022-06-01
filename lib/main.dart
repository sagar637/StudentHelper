import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:studenthelper/Community/AskQuestion/add_post_screen.dart';
import 'package:studenthelper/Community/Feed/feedmain.dart';
import 'package:studenthelper/Community/profile/profile_screen.dart';
import 'package:studenthelper/Courses/BCIS.dart';
import 'package:studenthelper/Courses/bba_bi.dart';
import 'package:studenthelper/Modelss/user.dart';
import 'package:studenthelper/Semester/bcis_sem.dart';
import 'package:studenthelper/subject/bcis_sem1.dart';
import 'package:studenthelper/subjectfiles/semester_pdf.dart';


import 'Community/AskQuestion/comment_screen.dart';
import 'Home/index.dart';
import 'Provider/user_provider.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );

  //await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'welcome_screen',

        routes: {
          'welcome_screen': (context) => const WelcomeScreen(),
          'registration_screen': (context) => SignupScreen(),
          'login_screen': (context) => const LoginScreen(),
          //'home_screen': (context) => HomeScreen(),
          //Course Routes
          'BBA_BI': (context) => const BBABI(),
          'BCIS': (context) => const BCIS(),

          //Semester Routes

          //Not needed now
          'semester_pdf': (context) => const SemesterPDF(),
          //Subject Route
          'bcis_sem1': (context) => const BCISSEMI(),
          //'sem1': (context) =>   const ImagePage(file: ,),
          //'Home' : (Context) => const DashBoardPage(),
          'dashboard': (Context) => const MobileScreenLayout(),


          //Community Routes
          'feedmain': (context) => const FeedScreen(),
          'add_post_screen': (context) => const AddPostScreen(),
          //'comment_screen' : (context) => CommentsScreen(postId: null,),
          //'profile_screen' : (Context) => ProfileScreen(uid : null),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const MobileScreenLayout(
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );


  }}





