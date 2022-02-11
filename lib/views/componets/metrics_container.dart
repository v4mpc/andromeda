import 'package:andromeda/models/all_models.dart';
import 'package:andromeda/services/service.dart';
import 'package:flutter/material.dart';
import 'mobility_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class MetricsContainer extends StatelessWidget {
  const MetricsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _measurement = Provider.of<Measurement?>(context);
    // print(context.watch<WeightService?>()!.measurement);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              text: _measurement?.value.toString()??'-',
              style: Theme.of(context).textTheme.headline2,
              children: [
                TextSpan(text: 'Kg', style: Theme.of(context).textTheme.caption)
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MobilityIndicator(number: 12),
        ),
        Text(
          '4 days ago',
          style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
        )
      ],
    );
  }
}
