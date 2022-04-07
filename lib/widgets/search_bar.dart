import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/screens/product/product.dart';

class SearchBar extends StatelessWidget {
  final List<Product> products;
  const SearchBar({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(products),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: const [
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(width: 10.0),
            Text(
              'Wyszukaj dany produkt...',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Product> products;
  CustomSearchDelegate(this.products);

  @override
  String get searchFieldLabel => 'Szukaj...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        //hintStyle: theme.textTheme.subtitle1.copyWith(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        focusColor: primaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: primaryColor, width: 0),
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0.0,
        color: primaryColor,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (Product product in products) {
      if (product.productName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index].productName),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (Product product in products) {
      if (product.productName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ProductPage(product: matchQuery[index])),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/products/${matchQuery[index].imagePath}',
                  height: 30.0,
                  width: 30.0,
                ),
                const SizedBox(width: 20.0),
                SizedBox(
                  width: 250.0,
                  child: Text(matchQuery[index].productName),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
