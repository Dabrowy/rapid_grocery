import 'package:flutter/material.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/screens/loading/loading.dart';
import 'package:rapid_grocery/services/auth.dart';
import 'package:rapid_grocery/widgets/input_decoration.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final Widget box = const SizedBox(height: 10.0);

  String email = '';
  String password = '';
  String password2 = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0.0,
              title: const Text('Zarejestruj się'),
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
                    'Zaloguj się',
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
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Powtórz hasło'),
                      validator: (value) => value!.length < 8
                          ? 'Hasło musi mieć co najmniej 8 znaków'
                          : null,
                      onChanged: (value) => setState(() => password2 = value),
                      obscureText: true,
                    ),
                    box,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        elevation: 0.0,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            password == password2) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Proszę wprowadzić prawidłowy email';
                              loading = false;
                            });
                          }
                        } else {
                          setState(() => error = 'Hasła nie są takie same');
                        }
                      },
                      child: const Text('Zarejestruj się'),
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
