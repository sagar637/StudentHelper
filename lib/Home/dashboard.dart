//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:studenthelper/Community/Feed/feedmain.dart';
// import 'package:studenthelper/Home/index.dart';
//
// import '../Community/AskQuestion/askquestionindex.dart';
// import '../Community/AskQuestion/comment_screen.dart';
// import 'home_screen.dart';
//
// class DashBoardPage extends StatefulWidget {
//   const DashBoardPage({Key? key}) : super(key: key);
//
//   @override
//   _DashBoardPageState createState() => _DashBoardPageState();
// }
//
// class _DashBoardPageState extends State<DashBoardPage> {
//   int pageIndex = 0;
//
//   final pages = [
//      HomeScreen(),
//     FeedScreen(),
//     AddPostScreen(),
//     const CommentsScreen(postId: null,)
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffC4DFCB),
//       appBar: AppBar(
//         // leading: Icon(
//         //   Icons.menu,
//         //   color: Theme.of(context).primaryColor,
//         // ),
//         title: Text(
//           "Online Student Helper",
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: pages[pageIndex],
//       bottomNavigationBar: buildMyNavBar(context),
//     );
//   }
//
//   Container buildMyNavBar(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 0;
//               });
//             },
//             icon: pageIndex == 0
//                 ? const Icon(
//               Icons.home_filled,
//               color: Colors.white,
//               size: 35,
//             )
//                 : const Icon(
//               Icons.home_outlined,
//               color: Colors.white,
//               size: 35,
//             ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 1;
//               });
//             },
//             icon: pageIndex == 1
//                 ? const Icon(
//               Icons.work_rounded,
//               color: Colors.white,
//               size: 35,
//             )
//                 : const Icon(
//               Icons.work_outline_outlined,
//               color: Colors.white,
//               size: 35,
//             ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 2;
//               });
//             },
//             icon: pageIndex == 2
//                 ? const Icon(
//               Icons.widgets_rounded,
//               color: Colors.white,
//               size: 35,
//             )
//                 : const Icon(
//               Icons.widgets_outlined,
//               color: Colors.white,
//               size: 35,
//             ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 3;
//               });
//             },
//             icon: pageIndex == 3
//                 ? const Icon(
//               Icons.person,
//               color: Colors.white,
//               size: 35,
//             )
//                 : const Icon(
//               Icons.person_outline,
//               color: Colors.white,
//               size: 35,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Home/home_screen.dart';

import '../Community/AskQuestion/add_post_screen.dart';
import '../Community/Feed/feedmain.dart';
import '../Community/profile/profile_screen.dart';
import '../Utilis/screenvariable.dart';
import '../constanst/constants.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,

        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: 'Notes',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.feed_outlined,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: 'Feed',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: 'Ask Question',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: 'Search',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: 'Notification',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 5) ? primaryColor : secondaryColor,
            ),
            label: 'Profile',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}