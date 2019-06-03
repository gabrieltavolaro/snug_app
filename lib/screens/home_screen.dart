import 'package:flutter/material.dart';
import 'package:loja_flutter/tabs/home_tab.dart';
import 'package:loja_flutter/tabs/services_tab.dart';
import 'package:loja_flutter/widgets/cart_button.dart';
import 'package:loja_flutter/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Serviços"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ServicesTab(),
          floatingActionButton: CartButton(),
        ),
        Container(color: Colors.blue,),
        Container(color: Colors.yellow,),
      ],
    );
  }
}
