import 'package:flutter/widgets.dart';

import '../Modelss/user.dart';
import '../Resources/auth_methos.dart';


// class UserProvider with ChangeNotifier {
//   User? _user;
//   final AuthMethods _authMethods = AuthMethods();
//
//   User get getUser => _user!;
//
//   Future<void> refreshUser() async {
//     User user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  Future<User?> get getUser async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    return _user;
  }

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}