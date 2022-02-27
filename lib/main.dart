import 'package:flutter/material.dart';
import 'views/main_page.dart';
import 'views/measurement_input_page.dart';
import 'theme/custom_theme.dart';
import 'package:flutter/widgets.dart';
import 'services/service.dart';
import 'package:provider/provider.dart';
import 'views/stats_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_)=>AppService())
      ],
      child: MaterialApp(

        title: 'Andromeda',

        // darkTheme: CustomTheme.darkTheme,
        theme: CustomTheme.lightTheme,
        themeMode: ThemeMode.system,
        routes: {
          '/': (context) => MainPage(),
          MainPage.route: (context) => MainPage(),
          MeasurementInputPage.route: (context) => MeasurementInputPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
