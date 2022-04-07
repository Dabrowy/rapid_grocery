import 'package:flutter/material.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/models/promo.dart';
import 'package:rapid_grocery/screens/home/widgets/category_card.dart';
import 'package:rapid_grocery/screens/home/widgets/featured_card.dart';
import 'package:rapid_grocery/screens/home/widgets/promo_card.dart';
import 'package:rapid_grocery/widgets/search_bar.dart';
import 'package:rapid_grocery/screens/home/widgets/section.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/screens/home/widgets/user_info_alert.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = Provider.of<List<Category>>(context);
    final List<Product> products = Provider.of<List<Product>>(context);
    final List<Promo> promos = Provider.of<List<Promo>>(context);
    final UserData userData = Provider.of<UserData>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (userData.name == '' ||
              userData.surname == '' ||
              userData.address == '' ||
              userData.postcode == '' ||
              userData.city == '')
            const UserAlert(),
          SearchBar(products: products),
          Section(
            title: 'Kategorie',
            children: categories.map((c) => CategoryCard(category: c)).toList(),
          ),
          Section(
            title: 'Dzisiejsze promocje',
            children: promos
                .map((p) => PromoCard(
                    promo: p, categories: categories, products: products))
                .toList(),
          ),
          Section(
            title: 'Polecane produkty',
            children: products.map((p) => FeaturedCard(product: p)).toList(),
          ),
        ],
      ),
    );
  }
}
