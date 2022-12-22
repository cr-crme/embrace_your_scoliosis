import 'package:flutter/material.dart';
import 'package:common_lib/widgets/login.dart';

import 'patient_overview_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Login(targetRouteName: PatientOverviewScreen.routeName)),
    );
  }
}
