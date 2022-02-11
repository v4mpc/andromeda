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

  const BmiCard({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BmiMeasurement? _bmiMeasurement = Provider.of<BmiMeasurement?>(context);

    const double horizontalSpace = 20;
    return AndromedaCard(
      title: 'BMI',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BmiLabel(color: Color(0xFFFF1744), text: 'Extreme Obese'),
              SizedBox(
                height: horizontalSpace,
              ),
              MetricsContainer(
              measurement:_bmiMeasurement,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBmiRefs(context,
                  color: Color(0xFF64B5F6),
                  title: 'Underweight',
                  subtitle: 'Less than 18.5'),
              const SizedBox(
                height: horizontalSpace,
              ),
              _buildBmiRefs(context,
                  color: Color(0xFF00E676),
                  title: 'Normal',
                  subtitle: '18.5 to 24.9'),
              const SizedBox(
                height: horizontalSpace,
              ),
              _buildBmiRefs(context,
                  color: Color(0xFFFF8A80),
                  title: 'Overweight',
                  subtitle: '25 to 29.9'),
              const SizedBox(
                height: horizontalSpace,
              ),
              _buildBmiRefs(context,
                  color: Color(0xFFFF5252),
                  title: 'Obese',
                  subtitle: '18.5 to 24.9'),
              const SizedBox(
                height: horizontalSpace,
              ),
              _buildBmiRefs(context,
                  color: Color(0xFFFF1744),
                  title: 'Extreme Obese',
                  subtitle: '25 to 29.9'),
            ],
          )
        ],
      ),
      color: color,
    );
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
