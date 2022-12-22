import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/dummy_database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/patient_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final dummy = dummyInitialDatabase();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'fr')),
        Provider<Database>(create: (_) => Database(dummy['users'])),
        ChangeNotifierProvider<PatientDataList>(
            create: (_) => dummy['patients']),
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
