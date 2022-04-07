class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String surname;
  final String address;
  final String postcode;
  final String city;

  UserData({
    required this.uid,
    required this.name,
    required this.surname,
    required this.address,
    required this.postcode,
    required this.city,
  });
}
