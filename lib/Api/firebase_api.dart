import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';


import '../Models/modeindex.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  // static Future downloadFile(Reference ref) async {

    // final islandRef = ref.child("Semester1/");
    //final url = await ref.getDownloadURL();
    // final dir = await getApplicationDocumentsDirectory();
    // final filePath = ('${dir.path}/${ref.name}');
    // final file  = File(filePath);
    // await Dio().download(url, file);


    // final downloadTask = islandRef.writeToFile(file);
    // downloadTask.snapshotEvents.listen((taskSnapshot) {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //       // TODO: Handle this case.
    //       break;
    //     case TaskState.paused:
    //       // TODO: Handle this case.
    //       break;
    //     case TaskState.success:
    //       // TODO: Handle this case.
    //       break;
    //     case TaskState.canceled:
    //       // TODO: Handle this case.
    //       break;
    //     case TaskState.error:
    //       // TODO: Handle this case.
    //       break;
    //   }
    // });
  static Future downloadFile(Reference ref) async {
final url = await ref.getDownloadURL();
final tempDir = await getTemporaryDirectory();
final path = '${tempDir.path}/${ref.name}';
await Dio().download(url, path).toString();


    if (url.contains('.pdf')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }
  }
}

