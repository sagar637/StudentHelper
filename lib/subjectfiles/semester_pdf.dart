import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../Api/firebase_api.dart';
import '../Models/firebase_file.dart';


class SemesterPDF extends StatefulWidget {
  const SemesterPDF({Key? key}) : super(key: key);

  @override
  State<SemesterPDF> createState() => _SemesterPDF();
}

class _SemesterPDF extends State<SemesterPDF> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('Semester1/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("sagar"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(files.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return buildFile(context, file);
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      );

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.file_download),
          onPressed: () {
              FirebaseApi.downloadFile(file.ref);

            // final snackBar = SnackBar(
            //   content: Text('Downloaded ${file.name}'),
            // );
          //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
        //   child: Image.network(
        //     file.url,
        //     width: 52,
        //     height: 52,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        // onTap: () => Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ImagePage(file: file),
        // )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}
