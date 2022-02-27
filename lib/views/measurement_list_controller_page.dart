import 'package:andromeda/models/all_models.dart';
import 'package:andromeda/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'measurement_list_page.dart';

class MeasurementListControllerPage extends StatelessWidget {
  const MeasurementListControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return MeasurementListPage(
            myList: snapshot.data,
          );
        } else {
          return MeasurementListPage(
            myList: [],
          );
        }
      },
      future: Provider.of<AppService>(context).getAllMeasurements(),
    );
  }
}
