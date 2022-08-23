import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Api/firebase_api.dart';
import '../Models/firebase_file.dart';



class SemesterPDF extends StatefulWidget {
  final snap;
  const SemesterPDF({Key? key, this.snap}) : super(key: key);

  @override
  State<SemesterPDF> createState() => _SemesterPDF();
}

class _SemesterPDF extends State<SemesterPDF> {

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(" Digital Notes "),
          backgroundColor: Colors.black
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(widget.snap!.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          // itemCount: files.length,
                          itemCount: widget.snap!.length,
                          itemBuilder: (context, index) {
                            final file = widget.snap[index]['file'];
                            return ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.file_download),
                                onPressed: ()
                                 async {
                                   var status = await Permission.storage.status;
                                   if (!status.isGranted) {
                                     await Permission.storage.request();

                                   }
                                     // var dir = await DownloadsPathProvider
                                     //     .downloadsDirectory;
                                     // if (dir != null) {
                                     Directory dir = Directory(
                                         '/storage/emulated/0/Download');
                                     // Directory? appDocDir = await getExternalStorageDirectory();
                                     // String appDocPath = appDocDir.path;
                                     String savename = widget
                                         .snap[index]['name'];
                                     String getFileExtension = "." + file.split('.').last;
                                     getFileExtension = getFileExtension.split('?').first;
                                   String savePath = dir.path + "/$savename" + getFileExtension;
                                     print(savePath);
                                     //output:  /storage/emulated/0/Download/banner.png
                                     try {
                                       Dio().download(
                                           file,
                                           savePath,
                                           onReceiveProgress: (received,
                                               total) {
                                             if (total != -1) {
                                               print((received / total * 100)
                                                   .toStringAsFixed(0) + "%");
                                               //you can build progressbar feature too
                                             }
                                           });
                                       print(
                                           "File is saved to download folder.");
                                     } on DioError catch (e) {
                                       print(e.message);
                                     }
                                     final snackBar = SnackBar(
                                       content: Text('Downloaded ${widget
                                           .snap[index]['name']}'),
                                     );
                                     ScaffoldMessenger.of(context).showSnackBar(
                                         snackBar);
                                     // };
                                   }

                              ),
                              //   child: Image.network(
                              //     file.url,
                              //     width: 52,
                              //     height: 52,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              title: Text(
                                widget.snap[index]['name'],
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
                          },
                        ),
                      ),
                    ],
                  ));


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
