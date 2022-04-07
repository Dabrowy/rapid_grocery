import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';

class Sort extends StatefulWidget {
  const Sort({Key? key}) : super(key: key);

  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  final _formKey = GlobalKey<FormState>();
  final Widget space = const SizedBox(height: 10.0);

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                const Text(
                  'Sortuj',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _selected = 0),
                  child: const Text(
                    'Resetuj',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            space,
            InkWell(
              onTap: () => setState(
                  () => {if (_selected != 1) _selected = 1 else _selected = 0}),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      child: Icon(
                        Icons.price_check,
                        size: 25.0,
                      ),
                    ),
                    const Positioned(
                      left: 25.0,
                      child: Text(
                        'od najnizszej ceny',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    if (_selected == 1)
                      const Positioned(
                        right: 0.0,
                        child: Icon(Icons.check),
                      ),
                  ],
                ),
              ),
            ),
            space,
            InkWell(
              onTap: () => setState(
                  () => {if (_selected != 2) _selected = 2 else _selected = 0}),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      child: Icon(Icons.event_available),
                    ),
                    const Positioned(
                      left: 25.0,
                      child: Text(
                        'od najwyzszej ceny',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    if (_selected == 2)
                      const Positioned(
                        right: 0.0,
                        child: Icon(Icons.check),
                      ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => setState(
                  () => {if (_selected != 3) _selected = 3 else _selected = 0}),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      child: Icon(Icons.mode_standby),
                    ),
                    const Positioned(
                      left: 25.0,
                      child: Text(
                        'od najpopularniejszych',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    if (_selected == 3)
                      const Positioned(
                        right: 0.0,
                        child: Icon(Icons.check),
                      ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  primary: primaryColor,
                  onPrimary: Colors.white,
                ),
                child: const Text(
                  'Sortuj',
                  style: TextStyle(fontSize: 17.5),
                ),
                onPressed: () {
                  if (_selected == 1) {
                    //choiceController.toHighest();
                  } else if (_selected == 2) {
                    //choiceController.toLowest();
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
