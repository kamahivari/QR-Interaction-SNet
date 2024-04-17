import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:fluttertoast/fluttertoast.dart";




class AuthService{
  final userCollection=FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void>signUp({required String name, required String email, required String password}) async{
    //kayit islemi
    try{
      final UserCredential userCredential= await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if(userCredential.user!=null){
      //null kontrolu
        _registerUser(name: name, email: email, password: password);
    }
    } on FirebaseAuthException catch (e){
      Fluttertoast.showToast(msg: e.message!);
      //hata tespit
    }
  }
   Future<void> signIn({ required email, required password}) async{
    //girisyapma
    try{
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!=null){
        //basarili giris
        Fluttertoast.showToast(msg: "Giriş yapıldı");
    }
    }
    on FirebaseAuthException catch (e){
      Fluttertoast.showToast(msg: e.message!);
    }

   }
  Future<void>_registerUser({required String name, required String email, required String password})async{
    //auth sonrasi kullanici kayidi
    await userCollection.doc().set({
      "email":email,"name":name,"password":password
    });
  }
  
}