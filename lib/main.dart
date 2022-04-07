import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/models/orders.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/models/promo.dart';
import 'package:rapid_grocery/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/services/auth.dart';
import 'package:rapid_grocery/services/database.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Category>>.value(
          value: DatabaseService(uid: '').allcategories,
          initialData: const [],
        ),
        StreamProvider<List<Product>>.value(
          value: DatabaseService(uid: '').allproducts,
          initialData: const [],
        ),
        StreamProvider<List<Promo>>.value(
          value: DatabaseService(uid: '').allpromos,
          initialData: const [],
        ),
        StreamProvider<List<Order>>.value(
          value: DatabaseService(uid: '').allorders,
          initialData: const [],
        ),
        StreamProvider<MyUser?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
