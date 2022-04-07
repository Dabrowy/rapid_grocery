import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/widgets/input_decoration.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final _formKey = GlobalKey<FormState>();
  final Widget space = const SizedBox(height: 10.0);

  bool _selectedDiscount = false;
  bool _selectedAvailibility = false;
  bool _error = false;
  double _pricerange1 = -1;
  double _pricerange2 = -1;

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
                  'Filtry',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                InkWell(
                  onTap: () => setState(() {
                    if (_selectedDiscount) {
                      _selectedDiscount = !_selectedDiscount;
                    }
                    if (_selectedAvailibility) {
                      _selectedAvailibility = !_selectedAvailibility;
                    }
                  }),
                  child: const Text(
                    'Resetuj',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Cena',
              style: TextStyle(fontSize: 30.0),
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: textInputDecoration,
                    onChanged: (value) => setState(() =>
                        _pricerange1 = value == '' ? -1 : double.parse(value)),
                  ),
                ),
                const SizedBox(width: 5.0),
                Container(
                  color: Colors.grey,
                  height: 1,
                  width: 15,
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: textInputDecoration,
                    onChanged: (value) => setState(() =>
                        _pricerange2 = value == '' ? -1 : double.parse(value)),
                  ),
                ),
              ],
            ),
            space,
            const Text(
              'Filtry produktów',
              style: TextStyle(fontSize: 30.0),
            ),
            space,
            InkWell(
              onTap: () =>
                  setState(() => _selectedDiscount = !_selectedDiscount),
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
                        'Przeceniony',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    if (_selectedDiscount)
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
                  () => _selectedAvailibility = !_selectedAvailibility),
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
                        'Dostępny w ',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    if (_selectedAvailibility)
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
                  'Zastosuj filtry',
                  style: TextStyle(fontSize: 17.5),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      ((_pricerange1 == -1 && _pricerange2 == -1) ||
                          (_pricerange1 < _pricerange2 &&
                              _pricerange1 != -1 &&
                              _pricerange2 != -1))) {
                    if (_pricerange1 < _pricerange2) {
                      //choiceController.priceRange(_pricerange1, _pricerange2);
                    }
                    if (_selectedAvailibility) {
                      //choiceController.availibility();
                    }
                    if (_selectedDiscount) {
                      //choiceController.discount();
                    }
                    Navigator.pop(context);
                  } else {
                    setState(() => _error = true);
                  }
                },
              ),
            ),
            if (_error == true)
              const Center(
                child: Text(
                  'Zakres ceny musi być prawidłowy!',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
