import 'package:flutter/material.dart';
import 'package:andromeda/views/measurement_input_page.dart';
import 'package:flutter/foundation.dart';
import 'home_page.dart';
import 'stats_page.dart';
import 'componets/all_componets.dart';
import 'measurement_list_controller_page.dart';
import 'measurement_list_page.dart';

class MainPage extends StatefulWidget {
  static const route = '/homepage';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final pages = [HomePage(), StatsPage(), MeasurementListControllerPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          CustomBottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
          ),
          CustomBottomNavigationBarItem(
            icon: Icon(Icons.insights),
          ),
          CustomBottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MeasurementInputPage.route);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
