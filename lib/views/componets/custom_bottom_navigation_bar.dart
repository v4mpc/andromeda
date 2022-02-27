import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function onTap;
  final List<CustomBottomNavigationBarItem> items;

  const CustomBottomNavigationBar(
      {Key? key,
      required this.currentIndex,
      required this.onTap,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((CustomBottomNavigationBarItem item) {
            int index = items.indexOf(item);
            return GestureDetector(
              onTap: () {
                _onTapItem(index);
              },
              child: IconTheme(
                data: IconThemeData(
                  size: currentIndex == index ? 35 : 25,
                  color: Theme.of(context).colorScheme.onPrimary
                ),
                child: item.icon,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onTapItem(int index) {
    onTap(index);
  }
}

class CustomBottomNavigationBarItem {
  final Widget icon;

  const CustomBottomNavigationBarItem({
    Key? key,
    required this.icon,
  });

// @override
// Widget build(BuildContext context) {
//   return Icon(
//     icon,
//     size: 35,
//     color: Theme.of(context).primaryColor,
//   );
// }
}
