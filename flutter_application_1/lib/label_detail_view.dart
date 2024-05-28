import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LabelDetailView extends StatelessWidget {
  final String labelId;
  final String userId;
  LabelDetailView(this.labelId, this.userId);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController numaraController = TextEditingController();
  final TextEditingController notController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController baslikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Label Detail")),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore
            .collection('users')
            .doc(userId)
            .collection('labels')
            .doc(labelId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final label = snapshot.data!;

          adController.text = label['Ad'];
          soyadController.text = label['Soyad'];
          numaraController.text = label['Numara'];
          notController.text = label['Not'];
          adresController.text = label['Adres'];
          baslikController.text = label['Baslik'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: baslikController,
                  decoration: InputDecoration(labelText: "Baslik"),
                ),
                TextField(
                  controller: adController,
                  decoration: InputDecoration(labelText: "Ad"),
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
                    await _firestore
                        .collection('users')
                        .doc(userId)
                        .collection('labels')
                        .doc(labelId)
                        .update({
                      'Baslik': baslikController.text,
                      'Ad': adController.text,
                      'Soyad': soyadController.text,
                      'Numara': numaraController.text,
                      'Not': notController.text,
                      'Adres': adresController.text,
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("Update"),
                ),
                SizedBox(height: 20),
                QrImageView(
                  data: '$userId|$labelId',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
