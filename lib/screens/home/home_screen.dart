import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/screens/account/account.dart';
import 'package:rapid_grocery/screens/cart/cart.dart';
import 'package:rapid_grocery/screens/categories/categories.dart';
import 'package:rapid_grocery/screens/home/home_body.dart';
import 'package:rapid_grocery/screens/orders/orders.dart';
import 'package:rapid_grocery/services/auth.dart';
import 'package:rapid_grocery/widgets/iconbottombar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;

  final List<Widget> screens = [
    const HomeBody(),
    const Categories(),
    const CartPage(),
    const OrdersPage(),
    const AccountPage(),
  ];

  final List<Text> headers = [
    const Text('Witamy w Rapid Grocery', style: TextStyle(fontSize: 17.5)),
    const Text('Kategorie'),
    const Text('Koszyk'),
    const Text('Twoje zamówienia'),
    const Text('Konto'),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: headers[_selected],
        centerTitle: false,
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () async {
              _auth.signOut();
            },
            icon: const Icon(Icons.people),
            label: const Text('Wyloguj się'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconBottomBar(
                text: 'Główna',
                icon: Icons.home,
                selected: _selected == 0,
                onPressed: () => setState(() => _selected = 0),
              ),
              IconBottomBar(
                text: 'Kategorie',
                icon: Icons.dehaze,
                selected: _selected == 1,
                onPressed: () => setState(() => _selected = 1),
              ),
              IconBottomBar(
                text: 'Koszyk',
                icon: Icons.local_grocery_store,
                selected: _selected == 2,
                onPressed: () => setState(() => _selected = 2),
              ),
              IconBottomBar(
                text: 'Zamówienia',
                icon: Icons.credit_card,
                selected: _selected == 3,
                onPressed: () => setState(() => _selected = 3),
              ),
              IconBottomBar(
                text: 'Konto',
                icon: Icons.account_box,
                selected: _selected == 4,
                onPressed: () => setState(() => _selected = 4),
              ),
            ],
          ),
        ),
      ),
      body: screens[_selected],
    );
  }
}
