import 'package:flutter/material.dart';
import 'package:common_lib/widgets/login.dart';

class LoginScreen extends StatelessWidget {
//LoginScreen is a StatelessWidget representing the login screen. It takes one required parameter:
  const LoginScreen(
      {super.key,
      required this.nextRoute}); // nextRoute: A string representing the name of the next route to navigate to after a successful login.

  static const routeName =
      '/login-screen'; // It's a route name for this screen. It is udes to navigate to this screen using the defined route name.
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Login(targetRouteName: nextRoute)),
      // Inside the Center widget, a Login widget is placed.
      // The Login widget is a custom widget define in common lib/widgets/login that represents a login form.
      // It takes a targetRouteName parameter, which is set to nextRoute.
      // This allows the login form to know which route to navigate to after a successful login.
    );
  }
}
