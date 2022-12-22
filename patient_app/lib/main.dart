import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/dummy_database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data_collection_devices/devices/available_devices.dart';
import '/models/theme.dart';
import '/screens/fetch_wearing_data_screen.dart';
import '/screens/home_screen.dart';
import '/screens/login_screen.dart';

void main() async {
  final dummy = dummyInitialDatabase();
  final database = Database(dummy['users']);
  // await database.login(username: 'first1@user.qc', password: '123456');

  runApp(
      MyApp(database: database, device: AvailableDevices.blueMaestroBleMock));
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
        ChangeNotifierProvider(create: (ctx) => PatientDataList()),
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.routeName,
        theme: enjoyYourBraceTheme,
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          FetchWearingDataScreen.routeName: (ctx) =>
              FetchWearingDataScreen(device: device),
        },
      ),
    );
  }
}
