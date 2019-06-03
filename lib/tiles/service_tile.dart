import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loja_flutter/screens/services_screen.dart';

class ServiceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ServiceTile(this.snapshot);

  IconData getIcon(String icon) {
    switch (icon) {
      case "hardHat":
        return FontAwesomeIcons.hardHat;
      case "broom":
        return FontAwesomeIcons.broom;
      case "bolt":
        return FontAwesomeIcons.bolt;
      case "hammer":
        return FontAwesomeIcons.hammer;
      case "paintRoller":
        return FontAwesomeIcons.paintRoller;
      case "wrench":
        return FontAwesomeIcons.wrench;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(getIcon(snapshot.data["icon"])),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ServicesScreen(snapshot))
        );
      },
    );
  }
}
