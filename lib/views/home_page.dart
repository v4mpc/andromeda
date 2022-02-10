import 'package:andromeda/views/componets/metrics_container.dart';
import 'package:flutter/material.dart';
import 'componets/all_componets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: const [
              Expanded(
                child: MeasurementCard(
                  title: 'Weight',
                  color: Color(0xFFA5D6A7),
                ),
              ),
              Expanded(
                child: MeasurementCard(
                  title: 'Height',
                  color: Color(0xFFA5D6A7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: const [
              Expanded(
                child: BmiCard(
                  color: Color(0xFFCDDC39),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
