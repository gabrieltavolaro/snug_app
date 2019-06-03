import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceData {

  String category;
  String id;
  String name;
  String description;
  int price;
  List images;
  List time;

  ServiceData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    name = snapshot.data["name"];
    description = snapshot.data["description"];
    price = snapshot.data["price"];
    images = snapshot.data["images"];
    time = snapshot.data["time"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "name" : name,
      "description" : description,
      "price" : price,
    };
  }

}