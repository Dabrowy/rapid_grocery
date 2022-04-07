import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rapid_grocery/constants/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const Text('Ładowanie...'),
      ),
      body: const Center(
        child: SpinKitRing(
          color: primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
