import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';

class UserAlert extends StatelessWidget {
  const UserAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
      padding: const EdgeInsets.all(5.0),
      height: 90.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset.zero,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Uzytkowniku!',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Nie uzupełniłeś swoich danych do przesyłki!\nZrób to teraz przechodząc do sekcji Konto w dolnej części ekranu, inaczej nie będziesz mógł złozyć zamówienia!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
