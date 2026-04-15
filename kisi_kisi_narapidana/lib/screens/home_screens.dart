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

// COMMENT FIREBASE

// 1. Comment untuk menginstall firebase    secara global
// -- npm install -g firebase-tools

// 2. Comment login firebase
// -- firebase login

// 3. Comment untuk melihat project firebase
// -- firebase projects:list

// 4. Comment membuat project baru firebase
// -- firebase projects:create

// 5. Comment logout firebase account
// -- firebase logout


// COMMENT FLUTTERFIRE

// Comment install flutterfire secara global
// -- dart pub global activate flutterfire_cli

// 2. Comment untuk menghubungkan project dengan project firebase
// -- flutterfire configure

// 3. Comment download dependency yang di butuhkan
// -- flutter pub add firebase_core

// -- flutter pub add firebase_database



// FUNGSI INSERT DELETE REALTIME DATABASE

//   void addShoppingItems(String itemName) {
//     _database.push().set({'name': itemName});
//   }

//   Future<void> removeShoppingItem(String key) async {
//     await _database.child(key).remove();
//   }

// cara buka firebase realtime database di browser
// 1. Buka browser dan masuk ke console.firebase.google.com
// 2. Pilih project yang sudah dibuat
// 3. Di menu sebelah kiri, klik "Database"
// 4. Pilih "Realtime Database"
// 5. Di bagian "Data", Anda dapat melihat struktur data yang telah Anda buat dan melakukan
// operasi seperti menambahkan, mengedit, atau menghapus data secara langsung melalui antarmuka web.
