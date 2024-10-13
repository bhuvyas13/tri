import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return CartItem(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 1,
    );
  }
}

class CartModel extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(0.0, (total, item) => total + (item.price * item.quantity));
  }

  Future<void> fetchItems() async {
    var snapshot = await FirebaseFirestore.instance.collection('cart').get();
    _items = snapshot.docs.map((doc) => CartItem.fromFirestore(doc)).toList();
    notifyListeners();
  }

  void addItem(CartItem item) {
    FirebaseFirestore.instance.collection('cart').doc(item.id).update({
      'quantity': item.quantity + 1,
    });
    fetchItems();
  }

  void removeItem(CartItem item) {
    if (item.quantity > 1) {
      FirebaseFirestore.instance.collection('cart').doc(item.id).update({
        'quantity': item.quantity - 1,
      });
    } else {
      FirebaseFirestore.instance.collection('cart').doc(item.id).delete();
    }
    fetchItems();
  }

  void clearCart() {
    FirebaseFirestore.instance.collection('cart').get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    _items.clear();
    notifyListeners();
  }
}
