import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/screens/loading/loading.dart';
import 'package:rapid_grocery/services/auth.dart';
import 'package:rapid_grocery/widgets/input_decoration.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final Widget box = const SizedBox(height: 10.0);

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0.0,
              title: const Text('Zaloguj się'),
              actions: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(Icons.person, size: 20.0),
                  label: const Text(
                    'Zarejestruj się',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wpisz email' : null,
                      onChanged: (value) => setState(() => email = value),
                    ),
                    box,
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Hasło'),
                      validator: (value) => value!.length < 8
                          ? 'Hasło musi mieć co najmniej 8 znaków'
                          : null,
                      onChanged: (value) => setState(() => password = value),
                      obscureText: true,
                    ),
                    box,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        elevation: 0.0,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Proszę wprowadzić prawidłowe dane';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: const Text('Zaloguj się'),
                    ),
                    box,
                    Text(
                      error,
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
