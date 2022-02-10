import 'package:andromeda/views/componets/metrics_container.dart';
import 'package:flutter/material.dart';
import 'views/componets/all_componets.dart';
import 'views/home_page.dart';
import 'views/measurement_input_page.dart';
import 'theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      routes: {
        '/': (context) => HomePage(),
        HomePage.route: (context) => HomePage(),
        MeasurementInputPage.route: (context) => MeasurementInputPage(),
      },
      initialRoute: '/',
    );
  }
}
