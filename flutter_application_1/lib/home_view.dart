import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_label_view_dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

import 'label_detail_view.dart';
import 'qr_scanner_view.dart';  // QR tarayıcı ekranını ekleyin

class HomeView extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Etiketlerim"),
         backgroundColor: Color.fromARGB(255, 0, 151, 101),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QrScannerView()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('users')
            .doc(user.uid)
            .collection('labels')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final labels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: labels.length,
            itemBuilder: (context, index) {
              final label = labels[index];

              return ListTile(
                title: Text(label['Baslik']),
                subtitle: Text(label['Ad']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _firestore
                        .collection('users')
                        .doc(user.uid)
                        .collection('labels')
                        .doc(label.id)
                        .delete();
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LabelDetailView(label.id, user.uid),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateLabelView(user.uid),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
