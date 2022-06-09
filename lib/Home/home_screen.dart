import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studenthelper/Widgets/homecard.dart';

import '../Api/firebase_api.dart';
import '../Models/firebase_file.dart';
import '../Utilis/utilis.dart';
import '../Widgets/post_card.dart';


late User loggedinUser;

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(" Online Student Helper"),
        backgroundColor: Colors.black
      ),
      body:
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),

        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );

          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              // margin: EdgeInsets.symmetric(
              //   horizontal: width > webScreenSize ? width * 0.3 : 0,
              //   vertical: width > webScreenSize ? 15 : 0,
              // ),
             child:
              Homecard(
                snap: snapshot.data!.docs[index].data(),

              ),

            ),
          );
        },
      ),
      // ListView(
      //     padding: const EdgeInsets.all(8),
      //     children: <Widget>[

          //   Card(
          //       child: ListTile(
          //           title: Text("BCIS"),
          //           subtitle: Text("BCIS Study Materials"),
          //           leading:
          //               CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
          //           trailing: Icon(Icons.arrow_forward),
          //           onTap: () {
          //             Navigator.pushNamed(context, 'BCIS');
          //           })),
          //   Card(
          //       child: ListTile(
          //           title: Text("BBA"),
          //           subtitle: Text("BBA Study Materials"),
          //           leading:
          //               CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
          //           trailing: Icon(Icons.arrow_forward))),
          //   Card(
          //       child: ListTile(
          //     title: Text("BBA-BI"),
          //     subtitle: Text("BBA-BI Study Materials"),
          //     leading: CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
          //     trailing: Icon(Icons.arrow_forward),
          //     // onTap: () {
          //     //   Navigator.pushNamed(context, 'BBA_BI');
          //     // }
          //   )),
          //   Card(
          //       child: ListTile(
          //           title: Text("MBA"),
          //           subtitle: Text("MBA Study Materials"),
          //           leading:
          //               CircleAvatar(backgroundImage: AssetImage("assets/1.jpg")),
          //           trailing: Icon(Icons.arrow_forward)))
          // ],),
    );


  }
}



// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'package:flutter/material.dart';
//
// import '../Api/firebase_api.dart';
// import '../Models/firebase_file.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreen();
// }
//
// class _HomeScreen extends State<HomeScreen> {
//   late Future<List<FirebaseFile>> futureFiles;
//
//   @override
//   void initState() {
//     super.initState();
//     futureFiles = FirebaseApi.listAll('English/');
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text("sagar"),
//       centerTitle: true,
//     ),
//     body: FutureBuilder<List<FirebaseFile>>(
//       future: futureFiles,
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Center(child: CircularProgressIndicator());
//           default:
//             if (snapshot.hasError) {
//               return Center(child: Text('Some error occurred!'));
//             } else {
//               final files = snapshot.data!;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildHeader(files.length),
//                   const SizedBox(height: 12),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: files.length,
//                       itemBuilder: (context, index) {
//                         final file = files[index];
//
//                         return buildFile(context, file);
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             }
//         }
//       },
//     ),
//   );
//
//   Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
//     trailing: IconButton(
//       icon: Icon(
//           Icons.file_download),
//       onPressed: () {
//         FirebaseApi.downloadFile(file.ref);
//
//         // final snackBar = SnackBar(
//         //   content: Text('Downloaded ${file.name}'),
//         // );
//         //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       },
//     ),
//     //   child: Image.network(
//     //     file.url,
//     //     width: 52,
//     //     height: 52,
//     //     fit: BoxFit.cover,
//     //   ),
//     // ),
//     title: Text(
//       file.name,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         decoration: TextDecoration.underline,
//         color: Colors.blue,
//       ),
//     ),
//     // onTap: () => Navigator.of(context).push(MaterialPageRoute(
//     //   builder: (context) => ImagePage(file: file),
//     // )),
//   );
//
//   Widget buildHeader(int length) => ListTile(
//     tileColor: Colors.blue,
//     leading: Container(
//       width: 52,
//       height: 52,
//       child: Icon(
//         Icons.file_copy,
//         color: Colors.white,
//       ),
//     ),
//     title: Text(
//       '$length Files',
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 20,
//         color: Colors.white,
//       ),
//     ),
//   );
// }
//
