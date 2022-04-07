import 'package:flutter/material.dart';

class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  const IconBottomBar({
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color: selected ? Colors.white : Colors.grey[400],
          iconSize: 25,
          onPressed: onPressed,
        ),
        Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey[400],
            fontSize: 12,
            height: 0.1,
          ),
        ),
      ],
    );
  }
}
