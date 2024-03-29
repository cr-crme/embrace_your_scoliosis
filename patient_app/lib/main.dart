import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data_collection_devices/devices/available_devices.dart';
import '/firebase_options.dart';
import '/models/theme.dart';
import '/screens/fetch_wearing_data_screen.dart';
import '/screens/login_screen.dart';
import '/screens/main_screen.dart';
import '/screens/permission_screen.dart';

void main() async {
  const useEmulator = false;
  final userDatabase = Database();
  await userDatabase.initialize(
      useEmulator: useEmulator,
      currentPlatform: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(
      database: userDatabase, device: AvailableDevices.blueMaestroBleMock));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database, required this.device});

  final AvailableDevices device;
  final Database database;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'fr')),
        Provider<Database>(create: (_) => database),
        ChangeNotifierProvider(create: (ctx) {
          final patientData = PatientDataList();
          patientData.initializeFetchingData();
          return patientData;
        }),
      ],
      child: MaterialApp(
        initialRoute: PermissionScreen.routeName,
        theme: enjoyYourBraceTheme,
        routes: {
          PermissionScreen.routeName: (ctx) => const PermissionScreen(
                nextRoute: LoginScreen.routeName,
              ),
          LoginScreen.routeName: (ctx) => const LoginScreen(
                nextRoute: FetchWearingDataScreen.routeName,
              ),
          FetchWearingDataScreen.routeName: (ctx) => FetchWearingDataScreen(
                device: device,
                nextRoute: MainScreen.routeName,
              ),
          MainScreen.routeName: (ctx) => const MainScreen(),
        },
      ),
    );
  }
}
