import 'package:flutter/material.dart';

class BmiLabel extends StatelessWidget {
  final Color color;
  final String text;

  const BmiLabel({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
