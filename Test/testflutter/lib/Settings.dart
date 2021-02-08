import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.black,
                  ),
                )),
        centerTitle: true,
        backgroundColor: Color(0xFFE0E0E0),
        title: Text('Settings', style: TextStyle(color: Colors.black),),
      ),
      //Grad an instance of the Firestore database
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('SETTINGS').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //Check if the snapshot grabbed any data from firestore
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, index) =>
                _buildListItem(context, snapshot.data.docs[index]),
          );
        },
      ),
    );
  }

  //Display data taken from firestore
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      shadowColor: Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
          //Display description information
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Radius: ' + document['Radius'].toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6),
          ),
            Padding(padding: EdgeInsets.all(5)),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
          //Display description information
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Interval: ' + document['Interval'].toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6),
          ),
            Padding(padding: EdgeInsets.all(5)),
          
        ],
      ),
    );
  }
}
