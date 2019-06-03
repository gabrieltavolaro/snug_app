import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_flutter/datas/cart_service.dart';
import 'package:loja_flutter/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {
  UserModel user;

  List<CartService> service = [];

  String couponCode;

  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if(user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartService cartService) {
    service.add(cartService);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartService.toMap())
        .then((doc) {
      cartService.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartService cartService) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartService.cid)
        .delete();

    service.remove(cartService);

    notifyListeners();

  }

  void decService(CartService cartService) {

    cartService.quantity--;

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document("sid").updateData(cartService.toMap());

    notifyListeners();

  }

  void incService(CartService cartService) {

    cartService.quantity++;

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document("sid").updateData(cartService.toMap());

    notifyListeners();

  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices(){
    notifyListeners();
  }

  double getServicesPrice(){
    double price = 0.0;
    for(CartService c in service) {
      if(c.serviceData != null)
        price += c.quantity * c.serviceData.price * int.parse(c.time);
    }
    return price;
  }

  double getDiscount(){
    return getServicesPrice() * discountPercentage / 100;
  }

  void _loadCartItems() async {

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    service = query.documents.map((doc) => CartService.fromDocument(doc)).toList();

    notifyListeners();

  }
}
