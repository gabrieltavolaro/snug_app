import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_flutter/datas/service_data.dart';

class CartService {

  String cid; // Cart ID
  String category; // Categoria do serviço
  String wid; // Worker ID

  int quantity;
  String time;

  String name;

  ServiceData serviceData;

  CartService();

  CartService.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["services"];
    name = document.data["name"];
    wid = document.data["wid"];
    quantity = document.data["quantity"];
    time = document.data["time"];

  }

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "service" : category,
      "wid" : wid,
      "quantity" : quantity,
      "time" : time,
      //"worker" : serviceData.toResumedMap(),
    };
  }

}