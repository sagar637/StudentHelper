import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../Models/modeindex.dart';


const debug = true;

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

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  static Future downloadFile(Reference ref) async {
    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    print(tempDir.path);
    //await Dio().download(url, path);


    FlutterDownloader.registerCallback(downloadCallback);
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: tempDir.path,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification: true,
      // click on notification to open downloaded file (for Android)
      saveInPublicStorage: true, //save files in local storage
    );
    return taskId;
  }


}
