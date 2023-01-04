import 'package:clinician_app/firebase_options.dart';
import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/patient_overview_screen.dart';

void main() async {
  const useEmulator = false;
  final userDatabase = Database();
  await userDatabase.initialize(
      useEmulator: useEmulator,
      currentPlatform: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(database: userDatabase));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({super.key, required this.database});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'fr')),
        Provider<Database>(create: (_) => database),
        ChangeNotifierProvider<PatientDataList>(
            create: (_) => PatientDataList()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) =>
              const LoginScreen(nextRoute: PatientOverviewScreen.routeName),
          PatientOverviewScreen.routeName: (context) =>
              const PatientOverviewScreen(),
        },
      ),
    );
  }
}
