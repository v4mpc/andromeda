import 'package:flutter/material.dart';

class AndromedaCard extends StatelessWidget {
  final Widget content;
  final Color color;
  final String title;

  const AndromedaCard(
      {Key? key, required this.title, required this.content, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 15,
            ),
            content
          ],
        ),
      ),
    );
  }
}
