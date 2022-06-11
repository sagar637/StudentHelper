import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studenthelper/Community/notification/notification.dart';
import 'package:studenthelper/Home/home_screen.dart';
import 'package:studenthelper/SemesterName/semester.dart';

import '../Community/AskQuestion/add_post_screen.dart';
import '../Community/Feed/feedmain.dart';
import '../Community/profile/profile_screen.dart';
import '../Community/search/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [

  HomeScreen(),
  const FeedScreen(),
  const AddPostScreen(),
  const SearchScreen(),
    Notifaction(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),

];