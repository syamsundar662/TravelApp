// ignore_for_file: avoid_print, camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trivo/screens/admin/screens/admin_homepage.dart';
import 'package:trivo/screens/screen_Login.dart';
import 'package:trivo/widgets/w_bottomNavbar.dart';

class F_authentication {
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously

   email == 'admin@gmail.com' || password == 'admina'  ? 
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Adminhome())):

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Navbar()));

    } on FirebaseAuthException catch (e) {
      print(e);

      if (email.isEmpty || password.isEmpty) {
        return;
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> createGmailandPassword(
      String email, String password, BuildContext context) async {
    try {
      final snap =await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (Context) => LoginPage()));
      saveUser(email, password, snap.user!.uid);
    } catch (e) {
      print("err");
    }
  }
}
saveUser(String email,String password,String id){
  FirebaseFirestore.instance.collection('users').doc(id).set({'email':email,'password':password,'id':id});
}
