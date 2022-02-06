import 'package:andromeda/views/componets/all_componets.dart';
import 'package:andromeda/views/componets/metrics_container.dart';
import 'package:flutter/material.dart';
import 'andromeda_card.dart';
import 'bmi_label.dart';

class BmiCard extends StatelessWidget {
  final Color color;

  const BmiCard({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndromedaCard(
      title: 'BMI',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BmiLabel(color: Colors.blue, text: 'Extreme Obese'),
              SizedBox(height: 5,),
              MetricsContainer(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBmiRefs(context,
                  color: Colors.green,
                  title: 'Underweight',
                  subtitle: 'Less than 18.5'),
              const SizedBox(
                height: 10,
              ),
              _buildBmiRefs(context,
                  color: Colors.blue,
                  title: 'Normal',
                  subtitle: '18.5 to 24.9'),
              const SizedBox(
                height: 10,
              ),
              _buildBmiRefs(context,
                  color: Colors.blue,
                  title: 'Overweight',
                  subtitle: '25 to 29.9'),
              const SizedBox(
                height: 10,
              ),
              _buildBmiRefs(context,
                  color: Colors.blue, title: 'Obese', subtitle: '18.5 to 24.9'),
              const SizedBox(
                height: 10,
              ),
              _buildBmiRefs(context,
                  color: Colors.blue,
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
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontStyle: FontStyle.italic),
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
