import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_grocery/constants/colors.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/screens/account/widgets/show_address.dart';
import 'package:rapid_grocery/screens/account/widgets/show_info.dart';
import 'package:rapid_grocery/screens/account/widgets/show_label.dart';
import 'package:rapid_grocery/screens/loading/loading.dart';
import 'package:rapid_grocery/services/database.dart';
import 'package:rapid_grocery/widgets/input_decoration.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _edit = false;
  bool _loading = false;
  final Widget box = const SizedBox(height: 10);
  String name = '';
  String surname = '';
  String address = '';
  String postcode = '';
  String city = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserData userInfo = Provider.of<UserData>(context);
    return _loading
        ? const Loading()
        : SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _edit == false
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/avatars/crysis.jpg'),
                                radius: 100.0,
                              ),
                            ),
                          ),
                          const Divider(height: 20.0),
                          const ShowLabel(first: 'Imię', second: 'Miasto'),
                          ShowInfo(first: userInfo.name, second: userInfo.city),
                          const ShowLabel(
                              first: 'Nazwisko', second: 'Kod pocztowy'),
                          ShowInfo(
                              first: userInfo.surname,
                              second: userInfo.postcode),
                          const ShowLabel(first: '', second: 'Adres'),
                          ShowAddress(address: userInfo.address),
                          const Divider(height: 20.0),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () => setState(() => _edit = true),
                            icon: const Icon(Icons.edit),
                            label: const Text('Edytuj dane'),
                          ),
                        ],
                      )
                    : Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Edytuj swoje dane',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              box,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Imię:',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    box,
                                    TextFormField(
                                      initialValue: userInfo.name,
                                      decoration: textInputDecoration,
                                      validator: (value) => value!.isEmpty
                                          ? 'Pole nie moze być puste!'
                                          : null,
                                      onChanged: (value) =>
                                          setState(() => name = value),
                                    ),
                                    box,
                                    const Text(
                                      'Nazwisko:',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    box,
                                    TextFormField(
                                      initialValue: userInfo.surname,
                                      decoration: textInputDecoration,
                                      validator: (value) => value!.isEmpty
                                          ? 'Pole nie moze być puste!'
                                          : null,
                                      onChanged: (value) =>
                                          setState(() => surname = value),
                                    ),
                                    box,
                                    const Text(
                                      'Adres:',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    box,
                                    TextFormField(
                                      initialValue: userInfo.address,
                                      decoration: textInputDecoration,
                                      validator: (value) => value!.isEmpty
                                          ? 'Pole nie moze być puste!'
                                          : null,
                                      onChanged: (value) =>
                                          setState(() => address = value),
                                    ),
                                    box,
                                    const Text(
                                      'Kod pocztowy:',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    box,
                                    TextFormField(
                                      initialValue: userInfo.postcode,
                                      decoration: textInputDecoration,
                                      validator: (value) => value!.isEmpty
                                          ? 'Pole nie moze być puste!'
                                          : null,
                                      onChanged: (value) =>
                                          setState(() => postcode = value),
                                    ),
                                    box,
                                    const Text(
                                      'Miasto:',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    box,
                                    TextFormField(
                                      initialValue: userInfo.city,
                                      decoration: textInputDecoration,
                                      validator: (value) => value!.isEmpty
                                          ? 'Pole nie moze być puste!'
                                          : null,
                                      onChanged: (value) =>
                                          setState(() => city = value),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 30.0,
                                color: Colors.grey,
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _loading = true);
                                    await DatabaseService(uid: userInfo.uid)
                                        .updateUserData(
                                      name == '' ? userInfo.name : name,
                                      surname == ''
                                          ? userInfo.surname
                                          : surname,
                                      address == ''
                                          ? userInfo.address
                                          : address,
                                      postcode == ''
                                          ? userInfo.postcode
                                          : postcode,
                                      city == '' ? userInfo.city : city,
                                    );
                                    setState(() {
                                      _edit = false;
                                      _loading = false;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Zapisz dane'),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
  }
}
