import 'package:flutter/material.dart';

class MinMaxContainer extends StatelessWidget {
  final String title;
  final String? value;
  final String? unit;
  final String? date;
  final Color color;

  const MinMaxContainer(
      {Key? key,
      required this.title,
      this.value,
      this.date,
      required this.color,
      this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: color,
              height: 90,
              width: 5,
            ),
            // Spacer(),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18),
                ),
                RichText(
                  text: TextSpan(
                    text: value??'-',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 40),
                    children: [
                      TextSpan(
                        text: unit??'',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(date??'-')
              ],
            )
          ],
        )
      ],
    );
  }
}
