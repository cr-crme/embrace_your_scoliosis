import 'package:ezlogin/ezlogin.dart';

import 'enums.dart';

class MainUser extends EzloginUser {
  final String firstName;
  final String lastName;
  final UserType userType;

  MainUser({
    required this.firstName,
    required this.lastName,
    required this.userType,
    required super.email,
    required super.shouldChangePassword,
    super.id,
  });
  MainUser.fromSerialized(map)
      : firstName = map['firstName'],
        lastName = map['lastName'],
        userType = UserType.values[map['userType']],
        super.fromSerialized(map);

  @override
  Map<String, dynamic> serializedMap() {
    return super.serializedMap()
      ..addAll({
        'firstName': firstName,
        'lastName': lastName,
        'userType': userType.index,
      });
  }

  @override
  MainUser deserializeItem(map) {
    return MainUser.fromSerialized(map);
  }

  @override
  MainUser copyWith({
    String? firstName,
    String? lastName,
    String? email,
    UserType? userType,
    bool? shouldChangePassword,
    String? notes,
    String? id,
  }) {
    firstName ??= this.firstName;
    lastName ??= this.lastName;
    email ??= this.email;
    userType ??= this.userType;
    shouldChangePassword ??= this.shouldChangePassword;
    id ??= this.id;
    return MainUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      userType: userType,
      shouldChangePassword: shouldChangePassword,
      id: id,
    );
  }
}
