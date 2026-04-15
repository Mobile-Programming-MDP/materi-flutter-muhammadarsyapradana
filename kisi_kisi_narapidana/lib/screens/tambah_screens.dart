import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TambahPage extends StatefulWidget {
  @override
  _TambahPageState createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {

  final nama = TextEditingController();
  final umur = TextEditingController();
  final kasus = TextEditingController();

  String jk = "Laki-laki";

  final dbRef = FirebaseDatabase.instance.ref("narapidana");

  simpanData(){
    dbRef.push().set({
      "nama": nama.text,
      "jk": jk,
      "umur": umur.text,
      "kasus": kasus.text
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Narapidana"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nama,
              decoration: InputDecoration(
                labelText: "Nama"
              ),
            ),

            DropdownButton(
              value: jk,
              items: [
                DropdownMenuItem(
                  child: Text("Laki-laki"),
                  value: "Laki-laki",
                ),
                DropdownMenuItem(
                  child: Text("Perempuan"),
                  value: "Perempuan",
                ),
              ],
              onChanged: (value){
                setState(() {
                  jk = value.toString();
                });
              },
            ),

            TextField(
              controller: umur,
              decoration: InputDecoration(
                labelText: "Umur"
              ),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: kasus,
              decoration: InputDecoration(
                labelText: "Kasus"
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: simpanData,
              child: Text("Simpan"),
            )

          ],
        ),
      ),
    );
  }
}