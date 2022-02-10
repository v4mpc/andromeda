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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline2!.fontSize),
              children:[
                TextSpan(
                    text: 'Kg',
                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: Theme.of(context).textTheme.caption!.fontSize)
                )
              ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MobilityIndicator(number: 12),
        ),
        Text('4 days ago')
      ],
    );
  }
}
