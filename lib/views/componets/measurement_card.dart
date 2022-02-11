import 'package:andromeda/models/all_models.dart';
import 'package:flutter/material.dart';
import 'andromeda_card.dart';
import 'metrics_container.dart';

class MeasurementCard extends StatelessWidget {
  final Color color;
  final String title;
  final Measurement? measurement;

  const MeasurementCard({
    Key? key,
    required this.color,
    required this.title,
   this.measurement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndromedaCard(
      title: title,
      color: color,
      content: MetricsContainer(
measurement: measurement,
      ),
    );
  }
}
