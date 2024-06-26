import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateLabelView extends StatelessWidget {
  final String userId;
  CreateLabelView(this.userId);

  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController numaraController = TextEditingController();
  final TextEditingController notController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController baslikController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Etiket Oluştur")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: baslikController,
              decoration: InputDecoration(labelText: "Baslik",border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12)))
            ),
            TextField(
              controller: adController,
              decoration: InputDecoration(labelText: "Ad",),
            ),
            TextField(
              controller: soyadController,
              decoration: InputDecoration(labelText: "Soyad"),
            ),
            TextField(
              controller: numaraController,
              decoration: InputDecoration(labelText: "Numara"),
            ),
            TextField(
              controller: notController,
              decoration: InputDecoration(labelText: "Not"),
            ),
            TextField(
              controller: adresController,
              decoration: InputDecoration(labelText: "Adres"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final docRef = await _firestore
                    .collection('users')
                    .doc(userId)
                    .collection('labels')
                    .add({
                  'Baslik': baslikController.text,
                  'Ad': adController.text,
                  'Soyad': soyadController.text,
                  'Numara': numaraController.text,
                  'Not': notController.text,
                  'Adres': adresController.text,
                });
                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
