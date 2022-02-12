import 'package:andromeda/views/componets/all_componets.dart';
import 'package:andromeda/views/componets/metrics_container.dart';
import 'package:flutter/material.dart';
import 'andromeda_card.dart';
import 'bmi_label.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../../models/all_models.dart';

class BmiCard extends StatelessWidget {
  final Color color;
  final BmiMeasurement? bmiMeasurement;
  final List<BmiRef> _bmiRefs = const [
    BmiRef(range: [1, 18.5], color: Color(0xFF64B5F6), name: 'Underweight'),
    BmiRef(range: [18.5, 24.9], color: Color(0xFF00E676), name: 'Normal'),
    BmiRef(range: [25, 29.9], color: Color(0xFFFF8A80), name: 'Overweight'),
    BmiRef(range: [30, 34.9], color: Color(0xFFFF5252), name: 'Obese'),
    BmiRef(range: [35, 100], color: Color(0xFFFF1744), name: 'Extreme Obese'),
  ];

  const BmiCard({Key? key, required this.color, this.bmiMeasurement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('build bmi called');
    final BmiMeasurement? _bmiMeasurement = bmiMeasurement;
    final BmiRef? foundRef = findBmiRef(_bmiMeasurement?.value);
    const double horizontalSpace = 20;
    return AndromedaCard(
      title: 'BMI',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (foundRef != null)
                BmiLabel(color: foundRef.color, text: foundRef.name),
              SizedBox(
                height: horizontalSpace,
              ),
              MetricsContainer(
                measurement: _bmiMeasurement,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _bmiRefs.map((BmiRef e) {
              String _subs = '';
              if (e.range[0] == 1) {
                _subs = 'Less than ${e.range[1]}';
              } else if (e.range[1] == 100) {
                _subs = 'Greater than than ${e.range[0]}';
              } else {
                _subs = '${e.range[0]} to ${e.range[1]}';
              }
              return Column(
                children: [
                  _buildBmiRefs(context,
                      color: e.color, title: e.name, subtitle: _subs),
                  if (e.range[1] != 100)
                    const SizedBox(
                      height: horizontalSpace,
                    )
                ],
              );
            }).toList(),
          )
        ],
      ),
      color: color,
    );
  }

  BmiRef? findBmiRef(num? value) {
    if (value != null) {
      // return _bmiRefs
      //     .where((BmiRef el) => value >= el.range[0] && value <= el.range[1])
      //     .toList()[0];
      for (var e in _bmiRefs){
        if (e.range[0] == 1) {
          if(value<e.range[1]){
            return e;
          }
        } else if (e.range[0] == 100) {
          if(value>e.range[1]){
            return e;
          }
        } else {
          if(value>=e.range[0]&&value<=e.range[1]){
            return e;
          }
        }
      }
    }
    return null;
  }

  Widget _buildColoredBox(BuildContext context, Color color) {
    return Container(
      height: 38,
      width: 5,
      color: color,
    );
  }

  Widget _buildBmiRefs(BuildContext context,
      {required Color color, required String title, required String subtitle}) {
    return Container(
      child: Row(
        children: [
          Row(
            children: [
              _buildColoredBox(context, color),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
