import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:studenthelper/Courses/BCIS.dart';
import 'package:studenthelper/Courses/bba_bi.dart';
import 'package:studenthelper/Pdfdownload/sem1.dart';
import 'package:studenthelper/Semester/bcis_sem.dart';
import 'package:studenthelper/subject/bcis_sem1.dart';
import 'package:studenthelper/subjectfiles/semester_pdf.dart';

import 'Home/index.dart';



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
    return MaterialApp(
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => const WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => const LoginScreen(),
        'home_screen': (context) => HomeScreen(),
        //Course Routes
        'BBA_BI': (context) => const BBABI(),
        'BCIS': (context) => const BCIS(),

        //Semester Routes

        //Not needed now
        'semester_pdf' : (context) => const SemesterPDF(),
        //Subject Route
        'bcis_sem1': (context) => const BCISSEMI(),
        //'sem1': (context) =>   const ImagePage(file: ,),
      },
    );
  }
}
