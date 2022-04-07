import 'package:flutter/material.dart';
import 'package:rapid_grocery/services/authenticate.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/services/database.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        initialData: UserData(
          uid: '',
          name: '',
          surname: '',
          address: '',
          postcode: '',
          city: '',
        ),
        child: const HomeScreen(),
      );
    }
  }
}
