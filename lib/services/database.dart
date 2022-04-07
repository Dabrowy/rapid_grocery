import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapid_grocery/models/category.dart';
import 'package:rapid_grocery/models/my_user.dart';
import 'package:rapid_grocery/models/orders.dart';
import 'package:rapid_grocery/models/product.dart';
import 'package:rapid_grocery/models/promo.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference clientinfo =
      FirebaseFirestore.instance.collection('ClientInfo');

  final CollectionReference categories =
      FirebaseFirestore.instance.collection('Categories');

  final CollectionReference products =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference promos =
      FirebaseFirestore.instance.collection('Promos');

  final CollectionReference orders =
      FirebaseFirestore.instance.collection('Orders');

  Future updateUserData(String name, String surname, String address,
      String postcode, String city) async {
    return await clientinfo.doc(uid).set({
      'Name': name,
      'Surname': surname,
      'Address': address,
      'Postcode': postcode,
      'City': city,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('Name'),
      surname: snapshot.get('Surname'),
      address: snapshot.get('Address'),
      postcode: snapshot.get('Postcode'),
      city: snapshot.get('City'),
    );
  }

  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Category(
        id: doc.id,
        title: doc.get('Title'),
        iconPath: doc.get('iconPath'),
        imagePath: doc.get('imagePath'),
      );
    }).toList();
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        categoryid: doc.get('categoryID'),
        id: doc.id,
        price: doc.get('Price'),
        productName: doc.get('productName'),
        productWeight: doc.get('productWeight'),
        imagePath: doc.get('imagePath'),
      );
    }).toList();
  }

  List<Promo> _promoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Promo(
        promoCategory: doc.get('promoCategory'),
        id: doc.get('ID'),
        title: doc.get('Title'),
        discount: doc.get('Discount'),
        date: doc.get('Date'),
        imagePath: doc.get('imagePath'),
      );
    }).toList();
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Order(
        id: doc.id,
        userID: doc.get('userID'),
        status: doc.get('Status'),
        date: doc.get('Date').toDate(),
        value: doc.get('Value'),
        cart: OrderCart(
          products: doc.get('productsIDs'),
          quantities: doc.get('productsQuantities'),
        ),
      );
    }).toList();
  }

  Future submitAnOrder(double value, OrderCart products) async {
    return await orders.doc().set({
      'userID': uid,
      'Status': 0,
      'Date': DateTime.now(),
      'Value': value,
      'productsIDs': products.products,
      'productsQuantities': products.quantities,
    });
  }

  Stream<List<Category>> get allcategories {
    return categories.snapshots().map(_categoryListFromSnapshot);
  }

  Stream<List<Product>> get allproducts {
    return products.snapshots().map(_productListFromSnapshot);
  }

  Stream<List<Promo>> get allpromos {
    return promos.snapshots().map(_promoListFromSnapshot);
  }

  Stream<List<Order>> get allorders {
    return orders.snapshots().map(_orderListFromSnapshot);
  }

  Stream<UserData> get userData {
    return clientinfo.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
