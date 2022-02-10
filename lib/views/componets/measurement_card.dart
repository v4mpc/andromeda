import 'package:flutter/material.dart';
import 'andromeda_card.dart';
import 'mobility_indicator.dart';
import 'metrics_container.dart';

class MeasurementCard extends StatelessWidget {

  final Color color;
  final String title;
  const MeasurementCard({Key? key, required this.color,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndromedaCard(
      title: title,
      color: color,
      content: MetricsContainer(),
    );
  }
}
