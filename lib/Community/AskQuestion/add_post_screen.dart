import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../Modelss/user.dart';
import '../../Provider/user_provider.dart';
import '../../Resources/auth_methos.dart';
import '../../Resources/firebase_method.dart';
import '../../Utilis/utilis.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  User? user;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    User _user = await AuthMethods().getUserDetails();
    setState(() {
      user = _user;
    });
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Ask your Question'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      return _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final UserProvider userProvider = Provider.of<UserProvider>(context);
  //
  //   return _file == null
  //       ? Center(
  //     child: IconButton(
  //       icon: const Icon(
  //         Icons.upload,
  //       ),
  //       onPressed: () => _selectImage(context),
  //     ),
  //   )
  //       : Scaffold(
  @override
  Widget build(BuildContext context) {
    return user == null
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : _file == null
            ? Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/Illustration.png',
                          height: 300,
                          width: 400,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          'Hey, Do you have a problem? ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            //decoration: TextDecoration.underline,
                            //decorationStyle: TextDecorationStyle.dashed,
                            //decorationColor: Colors.orange,
                            //decorationThickness: 3
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You can ask your friends about the problem ',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            //fontFeatures:
                            // decoration: TextDecoration.underline,
                            // decorationStyle: TextDecorationStyle.dashed,
                            // decorationThickness: 2,
                            // decorationColor: Colors.red,
                          ),
                        ),
                        Text(
                          'and discuss the solution here.',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            //fontFeatures:
                            // decoration: TextDecoration.underline,
                            // decorationStyle: TextDecorationStyle.dashed,
                            // decorationThickness: 2,
                            // decorationColor: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 80, 20, 5),
                          child: TextButton(
                            child: Text('Ask Here'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color.fromRGBO(143, 148, 251, 2),
                              fixedSize: Size.fromWidth(100),
                              onSurface: Colors.grey,
                            ),
                            onPressed: () => _selectImage(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //  child: Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //    children: [
                //      // IconButton(
                //      //   icon: const Icon(Icons.upload),
                //      //   onPressed: () => _selectImage(context),
                //      // ),
                //      Text("Hey Do you have a Problem? you ask Your friend"),
                //      SizedBox(width: 5,),
                // IconButton(
                //   icon: const Icon(Icons.upload),
                //   onPressed: () => _selectImage(context),
                // ),
                //    ],
                //
                //  ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(143, 148, 251, 2),
                  // backgroundColor: mobileBackgroundColor,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: clearImage,
                  ),
                  title: const Text(
                    'Post to',
                  ),
                  centerTitle: false,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => postImage(
                        user!.uid,
                        user!.username,
                        user!.photoUrl,
                      ),
                      child: const Text(
                        "Ask",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    )
                  ],
                ),
                // POST FORM
                body: Column(
                  children: <Widget>[
                    isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0.0)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            user!.photoUrl,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                                hintText: "Your First Question",
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 45.0,
                          width: 45.0,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                                image: MemoryImage(_file!),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
  }
}
