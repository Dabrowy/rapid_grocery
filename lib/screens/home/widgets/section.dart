import 'package:flutter/material.dart';
//import 'package:rapid_grocery/constants/colors.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const Section({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20.0, height: 1.0),
              ),
              /*InkWell(
                onTap: () {},
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Text(
                      'Wszystkie',
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.0,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 20.0,
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
