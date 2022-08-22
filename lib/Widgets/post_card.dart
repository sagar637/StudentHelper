import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthelper/Modelss/user.dart' as model;

import '../Community/AskQuestion/comment_screen.dart';
import '../Modelss/user.dart';
import '../Provider/user_provider.dart';
import '../Resources/auth_methos.dart';
import '../Resources/firebase_method.dart';
import '../Utilis/utilis.dart';
import '../constanst/constants.dart';
import 'like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;
  User? user;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
    postUserDispay();
  }

 postUserDispay() async {
   User _user = await AuthMethods().getUserDetails();
   setState(() {
     user = _user;
   });
 }
  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   // User? user = Provider.of<UserProvider>(context).getUser as model.User?;
    //final width = MediaQuery.of(context).size.width;

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
         color: Colors.white,
          width: 10.0,
          style: BorderStyle.solid,
        ),
        //borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20.0,
            spreadRadius: 20.0,
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
      ),

      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
      //   ),
      //   color: mobileBackgroundColor,
      // ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.snap['username'].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ),
                        Text(
                          ' Asked : ${ DateFormat.yMMMd()
                              .format(widget.snap['datePublished'].toDate())}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Text(
                //   ' Asked In : ${ DateFormat.yMMMd()
                //       .format(widget.snap['datePublished'].toDate())}',
                //
                //   style: const TextStyle(
                //     color: Colors.red,
                //   ),
                // ),
                widget.snap['uid'].toString() == user?.uid

                    ? IconButton(
                  onPressed: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                    child: Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16),
                                      child: Text(e),
                                    ),
                                    onTap: () {
                                      deletePost(
                                        widget.snap['postId']
                                            .toString(),
                                      );
                                      // remove the dialog box
                                      Navigator.of(context).pop();
                                    }),
                              )
                                  .toList()),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
                    : Container(
                ),

              ],

            ),

          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      widget.snap['description'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          GestureDetector(
            onDoubleTap: () {
              FireStoreMethods().likePost(
                widget.snap['postId'].toString(),
                user!.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: Row(

              children: <Widget>[
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user?.uid),
                  smallLike: true,
                  child: IconButton(
                    icon: widget.snap['likes'].contains(user?.uid)
                        ? const Icon(
                      Icons.thumb_up_rounded,
                      color: Colors.red,
                    )
                        : const Icon(
                      Icons.thumb_up_outlined,
                    ),

                    onPressed: () => FireStoreMethods().likePost(
                      widget.snap['postId'].toString(),
                      user!.uid,
                      widget.snap['likes'],
                    ),
                  ),
                ),
    Text(
    '${widget.snap['likes'].length} likes',
    style: Theme.of(context).textTheme.bodyText2,
    ),
                IconButton(
                  icon: const Icon(
                    Icons.mode_comment_sharp,
                  ),

                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
                Text(
                  ' $commentLen Answer',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.comment_bank_outlined,
                          ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              postId: widget.snap['postId'].toString(),
                            ),
                          ),
                        ),
                          ),
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Text(
                      'Submit Answer',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
                // Text(
                //   'Submit Answer',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     color: Colors.red,
                //   ),
                // ),
                // Expanded(
                //     child: Align(
                //       alignment: Alignment.bottomRight,
                //       child: IconButton(
                //           icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                //     ))
              ],
            ),
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       // DefaultTextStyle(
          //       //     style: Theme.of(context)
          //       //         .textTheme
          //       //         .subtitle2!
          //       //         .copyWith(fontWeight: FontWeight.w800),
          //           // child: Text(
          //           //   '${widget.snap['likes'].length} likes',
          //           //   style: Theme.of(context).textTheme.bodyText2,
          //           // )),
          //       Container(
          //         width: double.infinity,
          //         padding: const EdgeInsets.only(
          //           top: 8,
          //         ),
          //         child: RichText(
          //           text: TextSpan(
          //             style: const TextStyle(color: Colors.black),
          //             children: [
          //               TextSpan(
          //                 text: widget.snap['username'].toString(),
          //                 style: const TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               TextSpan(
          //                 text: ' ${widget.snap['description']}',
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       InkWell(
          //         child: Container(
          //           child: Text(
          //             'View all $commentLen comments',
          //             style: const TextStyle(
          //               fontSize: 16,
          //               color: Colors.red,
          //             ),
          //           ),
          //           padding: const EdgeInsets.symmetric(vertical: 4),
          //         ),
          //         onTap: () => Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => CommentsScreen(
          //               postId: widget.snap['postId'].toString(),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         child: Text(
          //           DateFormat.yMMMd()
          //               .format(widget.snap['datePublished'].toDate()),
          //           style: const TextStyle(
          //             color: Colors.red,
          //           ),
          //         ),
          //         padding: const EdgeInsets.symmetric(vertical: 4),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );

  }
}







