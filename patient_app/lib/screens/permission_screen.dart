// In summary, PermissionScreen is a screen that checks the status of location permission and either navigates to the next screen
// if the permission is already granted or requests permission and then navigates to the next screen.
// This is a common pattern in many mobile apps that require user permissions for location services.

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  // PermissionScreen is a StatelessWidget representing a screen used to request and check location permission.
  const PermissionScreen({super.key, required this.nextRoute});

  final String
      nextRoute; // nextRoute: A string representing the name of the next route to navigate to after handling the permission request.
  static const String routeName =
      '/permission-screen'; //  It's a constant string that defines a route name for this screen. It is used to navigate to this screen using the defined route name.

  Future<void> _requestLocationPermission(NavigatorState navigator) async {
    // _requestLocationPermission is a private method that requests location permission using the Permission.location from the permission_handler package.
    await [Permission.location].request();
    // Once the permission request is completed, it plans to navigate to another route using _planForPushReplacementNamed.
    _planForPushReplacementNamed(navigator, PermissionScreen.routeName);
  }

  void _planForPushReplacementNamed(NavigatorState navigator, String route) {
    // _planForPushReplacementNamed is a private method that schedules navigation to another route using Navigator.pushReplacementNamed after the current frame.
    //It uses WidgetsBinding.instance.addPostFrameCallback to ensure that the navigation occurs after the current frame,
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigator.pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<PermissionStatus>(
            future: Permission.location
                .status, // The future property is set to retrieve the current status of location permission.
            builder: (context, status) {
              // it checks the status of location permission when it has data.
              if (status.hasData) {
                if (status.data!.isGranted) {
                  // If the permission is granted, it plans to navigate to the nextRoute.
                  _planForPushReplacementNamed(
                      Navigator.of(context), nextRoute);
                } else {
                  _requestLocationPermission(Navigator.of(
                      context)); // If not, it requests location permission.
                }
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
