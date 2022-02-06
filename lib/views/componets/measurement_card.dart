import 'package:flutter/material.dart';
import 'andromeda_card.dart';
import 'mobility_indicator.dart';
import 'metrics_container.dart';

class MeasurementCard extends StatelessWidget {
  const MeasurementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndromedaCard(
      title: 'Weight',
      color: Colors.red,
      content: MetricsContainer(),
    );
  }
}
