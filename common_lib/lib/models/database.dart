import 'package:ezlogin/ezlogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_user.dart';

Map<String, dynamic> defineNewUser(
  EzloginUser user, {
  required String password,
}) =>
    {'user': user, 'password': password};

class Database extends EzloginMock {
  Database(super.initialDatabase);

  static Database of(BuildContext context, {listen = false}) =>
      Provider.of<Database>(context, listen: listen);

  @override
  MainUser? get currentUser => super.currentUser as MainUser?;

  @override
  Future<MainUser?> user(String username) async {
    return await super.user(username) as MainUser;
  }
}
