import 'package:flutter/material.dart';
import 'package:common_lib/widgets/login.dart';

import 'fetch_wearing_data_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Login(targetRouteName: FetchWearingDataScreen.routeName)),
    );
  }
}
