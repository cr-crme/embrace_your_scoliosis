import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key, required this.nextRoute});

  final String nextRoute;
  static const String routeName = '/permission-screen';

  Future<void> _requestLocationPermission(NavigatorState navigator) async {
    await [Permission.location].request();
    _planForPushReplacementNamed(navigator, PermissionScreen.routeName);
  }

  void _planForPushReplacementNamed(NavigatorState navigator, String route) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigator.pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<PermissionStatus>(
            future: Permission.location.status,
            builder: (context, status) {
              if (status.hasData) {
                if (status.data!.isGranted) {
                  _planForPushReplacementNamed(
                      Navigator.of(context), nextRoute);
                } else {
                  _requestLocationPermission(Navigator.of(context));
                }
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
