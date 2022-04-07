import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rapid_grocery/widgets/input_decoration.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/screens/category/widgets/options_bar.dart';
import 'package:rapid_grocery/screens/category/widgets/product.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/widgets/search_bar.dart';

List<Product> productsList(String category, List<Product> list) {
  List<Product> newList = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i].categoryid == category) newList.add(list[i]);
  }

  return newList;
}

void productPriceFilter(
    double priceRange1, double priceRange2, List<Product> list) {
  for (int i = 0; i < list.length; i++) {
    if (!(list[i].price > priceRange1 && list[i].price < priceRange2)) {
      list.removeAt(i);
    }
  }
}

class CategoryPage extends StatefulWidget {
  final Category category;
  const CategoryPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _formKey = GlobalKey<FormState>();
  int _choice = -1;
  bool _showPanel = false;
  bool _error = false;
  double _pricerange1 = -1;
  double _pricerange2 = -1;

  @override
  Widget build(BuildContext context) {
    final allproducts = Provider.of<List<Product>>(context);
    List<Product> products = productsList(widget.category.id, allproducts);

    if (_choice == 60 || _choice == 130 || _choice == 140) {
      productPriceFilter(_pricerange1, _pricerange2, products);
    }

    if (_choice == 70 || _choice == 80 || _choice == 130 || _choice == 140) {
      if (_choice == 70 || _choice == 130) {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        backgroundColor: primaryColor,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          if (_showPanel == true)
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const OptionsBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 5,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.price_check),
                          label: const Text('Przeceniony'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 5,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () => setState(() {
                            if (_choice == -1) _choice = 80;
                            if (_choice == 60) _choice += 80;
                            if (_choice == 70) _choice = 80;
                            if (_choice == 130) _choice = 140;
                          }),
                          icon: const Icon(Icons.add),
                          label: const Text('Od najwyzszej'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 5,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.event_available),
                          label: const Text('Dostępny'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 5,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () => setState(() {
                            if (_choice == -1) _choice = 70;
                            if (_choice == 60) _choice += 70;
                            if (_choice == 80) _choice = 70;
                            if (_choice == 140) _choice = 130;
                          }),
                          icon: const Icon(Icons.add),
                          label: const Text('Od najnizszej'),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Text(
                      'Cena',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: textInputDecoration,
                          onChanged: (value) => setState(() => _pricerange1 =
                              value == '' ? -1 : double.parse(value)),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: textInputDecoration,
                          onChanged: (value) => setState(() => _pricerange2 =
                              value == '' ? -1 : double.parse(value)),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        primary: primaryColor,
                        onPrimary: Colors.white,
                      ),
                      child: const Text(
                        'Zastosuj zakres ceny',
                        style: TextStyle(fontSize: 10.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _pricerange1 < _pricerange2 &&
                            _pricerange1 != -1 &&
                            _pricerange2 != -1) {
                          if (_error == true) setState(() => _error = false);
                          setState(() {
                            if (_choice == -1) _choice = 60;
                            if (_choice == 70 || _choice == 80) _choice += 60;
                          });
                        } else {
                          setState(() => _error = true);
                        }
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        primary: primaryColor,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () => setState(() {
                        if (_choice == 60) _choice = -1;
                        if (_choice == 130 || _choice == 140) _choice -= 60;
                      }),
                      child: const Text(
                        'Zresetuj zakres',
                        style: TextStyle(fontSize: 10.0),
                      ),
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
          SearchBar(products: products),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                for (int i = 0; i < products.length; i++)
                  ProductCard(product: products[i])
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _showPanel = !_showPanel),
        backgroundColor: primaryColor,
        elevation: 0.0,
        child: const Icon(Icons.checklist),
      ),
    );
  }
}
