import 'package:andromeda/views/componets/metrics_container.dart';
import 'package:flutter/material.dart';
import 'componets/all_componets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: MeasurementCard(),
              ),
              Expanded(
                child: MeasurementCard(),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(
                child: BmiCard(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),

      ],
    );
  }
}
