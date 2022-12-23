import 'package:ezlogin/ezlogin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_user.dart';

Map<String, dynamic> defineNewUser(
  EzloginUser user, {
  required String password,
}) =>
    {'user': user, 'password': password};

class Database extends EzloginFirebase {
  ///
  /// This is an internal structure to quickly access the current
  /// user information. These may therefore be out of sync with the database
  ///
  MainUser? _currentUser;

  static Database of(BuildContext context, {listen = false}) =>
      Provider.of(context, listen: listen);

  @override
  MainUser? get currentUser => _currentUser;

  @override
  Future<EzloginStatus> login({
    required String username,
    required String password,
    Future<EzloginUser?> Function()? getNewUserInfo,
    Future<String?> Function()? getNewPassword,
  }) async {
    final status = await super.login(
        username: username,
        password: password,
        getNewUserInfo: getNewUserInfo,
        getNewPassword: getNewPassword);
    _currentUser = await user(username);
    return status;
  }

  @override
  Future<EzloginStatus> logout() {
    _currentUser = null;
    return super.logout();
  }

  @override
  Future<EzloginStatus> modifyUser(
      {required EzloginUser user, required EzloginUser newInfo}) async {
    final status = await super.modifyUser(user: user, newInfo: newInfo);
    if (user.email == currentUser?.email) {
      _currentUser = await this.user(user.email);
    }
    return status;
  }

  @override
  Future<MainUser?> user(String username) async {
    final id = emailToPath(username);
    final data = await FirebaseDatabase.instance.ref('$usersPath/$id').get();
    return data.value == null ? null : MainUser.fromSerialized(data.value);
  }
}
