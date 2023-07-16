import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trivo/screens/Login_page.dart';
import 'package:trivo/widgets/bottomnavbar.dart';

class f_authentication {
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(

          context, MaterialPageRoute(builder: (context) => Navbar()));
    } on FirebaseAuthException catch (e) {
      print(e);
       
       if (email.isEmpty||password.isEmpty ){
        return;
       }       
       else
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid email or password'),backgroundColor: Colors.red,));
    }
    
  }

  Future<void> createGmailandPassword(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (Context) => LoginPage()));
    } catch (e) {
      print("err");
    }
  }



}
