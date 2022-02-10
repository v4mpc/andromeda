import 'package:flutter/material.dart';
import 'mobility_indicator.dart';


class MetricsContainer extends StatelessWidget {
  const MetricsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              text: '1000',
              style: Theme.of(context).textTheme.headline2,
              children:[
                TextSpan(
                    text: 'Kg',
                    style: Theme.of(context).textTheme.caption
                )
              ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MobilityIndicator(number: 12),
        ),
        Text('4 days ago',style: TextStyle(color:Theme.of(context).textTheme.caption!.color),)
      ],
    );
  }
}
