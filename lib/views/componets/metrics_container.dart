import 'package:andromeda/models/all_models.dart';
import 'package:flutter/material.dart';
import 'mobility_indicator.dart';

class MetricsContainer extends StatelessWidget {
  final Measurement? measurement;

  const MetricsContainer({Key? key, this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? un = '';
    if (measurement?.unit.name != 'Bmi') un = measurement?.unit.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              text: measurement?.value.toString() ?? '-',
              style: Theme.of(context).textTheme.headline2,
              children: [
                TextSpan(
                    text: un,
                    style: Theme.of(context).textTheme.caption)
              ]),
        ),
        if (measurement?.mobility != 0 && measurement != null)
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MobilityIndicator(
                number: measurement?.mobility.toDouble() ?? 0),
          ),
        Text(
          measurement?.date ?? '-',
          style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
        )
      ],
    );
  }
}
