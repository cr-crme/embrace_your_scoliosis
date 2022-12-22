import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/dummy_database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/patient_overview_screen.dart';

void main() {
  final dummy = dummyInitialDatabase();
  final database = Database(dummy['users']);
  final patients = dummy['patients'];
  // await database.login(username: 'clinician@user.qc', password: '123456');

  runApp(MyApp(
    database: database,
    patientList: patients,
  ));
}

class MyApp extends StatelessWidget {
  final Database database;
  final PatientDataList? patientList;

  const MyApp({super.key, required this.database, this.patientList});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'fr')),
        Provider<Database>(create: (_) => database),
        ChangeNotifierProvider<PatientDataList>(
            create: (_) => patientList ?? PatientDataList()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          PatientOverviewScreen.routeName: (context) =>
              const PatientOverviewScreen(),
        },
      ),
    );
  }
}
