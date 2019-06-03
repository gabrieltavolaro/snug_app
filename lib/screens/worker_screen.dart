import 'package:flutter/material.dart';
import 'package:loja_flutter/datas/cart_service.dart';
import 'package:loja_flutter/datas/service_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_flutter/models/cart_model.dart';
import 'package:loja_flutter/models/user_model.dart';
import 'package:loja_flutter/screens/cart_screen.dart';
import 'package:loja_flutter/screens/login_screen.dart';

class WorkerScreen extends StatefulWidget {
  final ServiceData worker;

  WorkerScreen(this.worker);

  @override
  _WorkerScreenState createState() => _WorkerScreenState(worker);
}

class _WorkerScreenState extends State<WorkerScreen> {
  final ServiceData worker;

  String time;

  String name;

  _WorkerScreenState(this.worker);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(worker.name),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.4,
            child: Carousel(
              images: worker.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  worker.name,
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$${worker.price}/h",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Carga horária (em horas)",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: worker.time.map((t) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            time = t.toString();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color:
                                  t.toString() == time ? primaryColor : Colors.grey[500],
                              width: 1.6,
                            ),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(t.toString()),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: time != null ? (){
                      if(UserModel.of(context).isLoggedIn()) {

                        CartService cartService = CartService();
                        cartService.time = time;
                        cartService.quantity = 1;
                        cartService.wid = worker.id;
                        cartService.category = worker.category;
                        cartService.name = worker.name;

                        CartModel.of(context).addCartItem(cartService);

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CartScreen())
                        );

                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn() ?
                      "Contratar" :
                      "Entre para Contratar",
                      style: TextStyle(
                          fontSize: 20.0,
                      ),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  worker.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
