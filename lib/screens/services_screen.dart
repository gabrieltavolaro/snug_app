import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_flutter/datas/service_data.dart';
import 'package:loja_flutter/tiles/workers_tile.dart';

class ServicesScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ServicesScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("services")
                .document(snapshot.documentID)
                .collection("workers")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ServiceData data = ServiceData.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return WorkersTile(
                            "grid", data);
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ServiceData data = ServiceData.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return WorkersTile(
                            "list", data);
                      },
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}
