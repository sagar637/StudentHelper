import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Community/Feed/feedmain.dart';
import 'package:studenthelper/Home/home_screen.dart';
import '../../Home/login_screen.dart';
import '../../Resources/auth_methos.dart';
import '../../Resources/firebase_method.dart';
import '../../Utilis/utilis.dart';
import '../../Widgets/follow_button.dart';
import '../../constanst/constants.dart';


class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(143, 148, 251, 2),
        title: Text(
          userData['username'],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: primaryColor,
            ),
            onPressed: () async {
              await AuthMethods().signOut();
              Navigator.of(context)
                  .pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                    const LoginScreen(),
                  ) );
            }
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        userData['photoUrl'],
                      ),
                      radius: 60,
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         mainAxisSize: MainAxisSize.max,
                    //         mainAxisAlignment:
                    //         MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           buildStatColumn(postLen, "posts"),
                    //           buildStatColumn(followers, "followers"),
                    //           buildStatColumn(following, "following"),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment:
                    //         MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           FirebaseAuth.instance.currentUser!.uid ==
                    //               widget.uid
                    //               ? FollowButton(
                    //             text: 'Your Profile',
                    //             // backgroundColor:
                    //             // mobileBackgroundColor,
                    //             textColor: Colors.blue,
                    //             borderColor: Colors.red,
                    //             function: () async {
                    //               await AuthMethods().signOut();
                    //               Navigator.of(context)
                    //                   .pushReplacement(
                    //                 MaterialPageRoute(
                    //                   builder: (context) =>
                    //                      const LoginScreen( ),
                    //                 ),
                    //               );
                    //             },
                    //           )
                    //               : isFollowing
                    //               ? FollowButton(
                    //             text: 'Unfollow',
                    //             //backgroundColor: Colors.white,
                    //             textColor: Colors.black,
                    //             borderColor: Colors.grey,
                    //             function: () async {
                    //               await FireStoreMethods()
                    //                   .followUser(
                    //                 FirebaseAuth.instance
                    //                     .currentUser!.uid,
                    //                 userData['uid'],
                    //               );
                    //
                    //               setState(() {
                    //                 isFollowing = false;
                    //                 followers--;
                    //               });
                    //             },
                    //           )
                    //               : FollowButton(
                    //             text: 'Follow',
                    //             //backgroundColor: Colors.blue,
                    //             textColor: Colors.white,
                    //             borderColor: Colors.blue,
                    //             function: () async {
                    //               await FireStoreMethods()
                    //                   .followUser(
                    //                 FirebaseAuth.instance
                    //                     .currentUser!.uid,
                    //                 userData['uid'],
                    //               );
                    //
                    //               setState(() {
                    //                 isFollowing = true;
                    //                 followers++;
                    //               });
                    //             },
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Text(
                    userData['username'],
                    style:  const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      buildStatColumn(postLen, "Questions"),
                      buildStatColumn(postLen, "Likes"),
                      buildStatColumn(followers, "followers"),
                      buildStatColumn(following, "following"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        FirebaseAuth.instance.currentUser!.uid ==
                            widget.uid
                            ? FollowButton(
                          text: 'Your Profile',
                          // backgroundColor:
                          // mobileBackgroundColor,
                          textColor: Colors.black,
                          borderColor: Colors.black,
                          function: () async {
                            await AuthMethods().signOut();
                            Navigator.of(context)
                                .pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                   const LoginScreen( ),
                              ),
                            );
                          },
                        )
                            : isFollowing
                            ? FollowButton(
                          text: 'Unfollow',
                          //backgroundColor: Colors.white,
                          textColor: Colors.black,
                          borderColor: Colors.grey,
                          function: () async {
                            await FireStoreMethods()
                                .followUser(
                              FirebaseAuth.instance
                                  .currentUser!.uid,
                              userData['uid'],
                            );

                            setState(() {
                              isFollowing = false;
                              followers--;
                            });
                          },
                        )
                            : FollowButton(
                          text: 'Follow',
                          //backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          borderColor: Colors.blue,
                          function: () async {
                            await FireStoreMethods()
                                .followUser(
                              FirebaseAuth.instance
                                  .currentUser!.uid,
                              userData['uid'],
                            );

                            setState(() {
                              isFollowing = true;
                              followers++;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: 13,
                  ),

                  child: RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children:  [
                                   TextSpan(
                                    text: 'About Me',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ),

                  // child: Text(
                  //   ' About Me:'
                  //       ' ${ userData['bio']}',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //   ),
                  // ),
                ),
                Divider(
                  indent: 100,
                  endIndent: 100,
                  thickness: 5,
                  color: Colors.black,
                ),
             Padding(
               padding: const EdgeInsets.all(12.0),
               child: Text(
                 ' ${ userData['bio']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
             ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Question Asked',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const Divider(
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 1.5,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot snap =
                  (snapshot.data! as dynamic).docs[index];
                  return  Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FeedScreen()));
                        },
                        child: Image( image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover)),
                    // child: Image(
                    //   image: NetworkImage(snap['postUrl']),
                    //   fit: BoxFit.cover,
                    // ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}