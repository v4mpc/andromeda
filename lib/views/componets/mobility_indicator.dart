import 'package:flutter/material.dart';

class MobilityIndicator extends StatelessWidget {
  final double number;

  const MobilityIndicator({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: number < 0 ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 1),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  number < 0
                      ? '-${number.toString()}'
                      : '+${number.toString()}',
                ),
                number < 0
                    ? Icon(
                        Icons.arrow_downward,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      )
                    : Icon(
                        Icons.arrow_upward,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
