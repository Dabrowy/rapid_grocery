import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/screens/category/widgets/filters.dart';
import 'package:rapid_grocery/screens/category/widgets/sort.dart';

class OptionsBar extends StatelessWidget {
  const OptionsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showFilterPanel() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          builder: (context) {
            return const Filters();
          });
    }

    void _showSortPanel() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          builder: (context) {
            return const Sort();
          });
    }

    return Container(
      height: 50,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: InkWell(
                //onTap: () => _showFilterPanel(),
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.checklist,
                        color: Colors.white,
                      ),
                      Text(
                        'Filtry',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(width: 50, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: InkWell(
                //onTap: () => _showSortPanel(),
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                      Text(
                        'Sortuj',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
