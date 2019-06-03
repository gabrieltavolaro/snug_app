import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_flutter/datas/cart_service.dart';
import 'package:loja_flutter/datas/service_data.dart';
import 'package:loja_flutter/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartService cartService;

  CartTile(this.cartService);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {

      CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 150.0,
            child: Image.network(
              cartService.serviceData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cartService.serviceData.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    "Carga horária: ${cartService.time} horas",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0,
                    ),
                  ),
                  Text( // Parei o video no 7:13
                    "R\$${cartService.serviceData.price}/h",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row( // A quantidade de serviços
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.remove),
                          color: Theme.of(context).primaryColor,
                          onPressed: cartService.quantity > 1 ?
                          () { // Decrementar
                            CartModel.of(context).decService(cartService);
                          } : null,
                      ),
                      Text(
                        cartService.quantity.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: (){ // Incrementar
                          CartModel.of(context).incService(cartService);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartService);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cartService.serviceData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("services")
                    .document(cartService.category)
                    .collection("workers")
                    .document(cartService.wid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartService.serviceData =
                        ServiceData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent());
  }
}
