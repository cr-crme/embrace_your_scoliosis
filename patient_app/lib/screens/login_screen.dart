import 'package:flutter/material.dart';
import 'package:common_lib/widgets/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.nextRoute});

  static const routeName = '/login-screen';
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Login(targetRouteName: nextRoute)),
    );
  }
}
