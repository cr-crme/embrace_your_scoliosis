// this code sets up the Flutter application, initializes Firebase, and configures providers for managing application data and state.
// The MyApp widget serves as the entry point for the application's UI, and it defines the theme and initial routes for navigation.

import 'package:clinician_app/firebase_options.dart';
import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/patient_overview_screen.dart';

// The code imports various packages and modules necessary for the application,
// including Firebase-related dependencies, Flutter widgets, and custom modules.

void main() async {
  const useEmulator =
      false; // determines whether the Firebase emulator should be used.
  final userDatabase = Database();
  await userDatabase.initialize(
      // sets up Firebase configuration based on whether the emulator should be used or not
      useEmulator: useEmulator,
      currentPlatform: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(database: userDatabase)); // function to run the MyApp widget.
}

class MyApp extends StatelessWidget {
  // Stateless widget that represents the entire Flutter application
  final Database database;

  const MyApp(
      {super.key,
      required this.database}); // It takes an instance of the Database class as a parameter.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => LocaleText(
                language:
                    'fr')), // A provider for managing the application's localized text.
        Provider<Database>(
            create: (_) =>
                database), // A provider for providing the Database instance.
        ChangeNotifierProvider<PatientDataList>(create: (_) {
          // A provider for managing a list of patient data.
          final patients = PatientDataList();
          patients.initializeFetchingData();
          return patients;
        }),
      ],
      child: MaterialApp(
        // This widget is the root of the Flutter application and defines various properties such as the theme and initial route.
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: LoginScreen
            .routeName, // specifies the first screen that will be displayed when the app launches.
        routes: {
          // specifies routes for the LoginScreen and PatientOverviewScreen
          LoginScreen.routeName: (context) =>
              const LoginScreen(nextRoute: PatientOverviewScreen.routeName),
          PatientOverviewScreen.routeName: (context) =>
              const PatientOverviewScreen(),
        },
      ),
    );
  }
}
