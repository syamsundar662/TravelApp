// ignore_for_file: avoid_print, camel_case_types, use_build_context_synchronously, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trivo/screens/admin/screens/admin_homepage.dart';
import 'package:trivo/screens/screen_login.dart';
import 'package:trivo/widgets/w_bottomnavbar.dart';

class F_authentication {
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      email == 'admin@gmail.com'
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Adminhome()),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Navbar()),
              (route) => false);
    } on FirebaseAuthException catch (e) {
      print(e);

      if (email.isEmpty || password.isEmpty) {
        return;
      } else {
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
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Color.fromARGB(255, 211, 8, 8),
            content: Text('Weak password')));
      } else if (!email.contains('@gmail.com')) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Color.fromARGB(255, 211, 8, 8),
            content: Text('Invalid gmail ID')));
      }
      final snap = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Color.fromARGB(177, 10, 124, 162),
          content: Text('Successfully Created')));

      Navigator.push(
          context, MaterialPageRoute(builder: (Context) => const LoginPage()));
      saveUser(email, password, snap.user!.uid);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Color.fromARGB(255, 211, 8, 8),
              content: Text('The email address is already registered')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Color.fromARGB(255, 211, 8, 8),
              content: Text('Something went wrong!')));
        }
      }
    }
  }
}

saveUser(String email, String password, String id) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .set({'email': email, 'password': password, 'id': id});
}
