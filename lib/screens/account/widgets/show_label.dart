import 'package:flutter/material.dart';

class ShowLabel extends StatelessWidget {
  final String first;
  final String second;

  const ShowLabel({
    Key? key,
    required this.first,
    required this.second,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            first,
            style: const TextStyle(
              fontSize: 12.5,
            ),
          ),
          Text(
            second,
            style: const TextStyle(
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
