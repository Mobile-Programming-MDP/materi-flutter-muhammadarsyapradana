import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kisi_kisi_narapidana/screens/tambah_screens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbRef = FirebaseDatabase.instance.ref("narapidana");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Narapidana"),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahPage()),
          );
        },
      ),

      body: StreamBuilder<DatabaseEvent>(
  stream: dbRef.onValue,
  builder: (context, snapshot) {

    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    final data = snapshot.data!.snapshot.value as Map?;

    if (data == null) {
      return Center(child: Text("Data kosong"));
    }

    List item = data.values.toList();

    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(item[index]['nama']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("JK : ${item[index]['jk']}"),
                Text("Umur : ${item[index]['umur']}"),
                Text("Kasus : ${item[index]['kasus']}"),
              ],
            ),
          ),
        );
      },
    );
  },
),
    );
  }
}