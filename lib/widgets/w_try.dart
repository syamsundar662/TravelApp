import 'package:flutter/material.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/screens/admin/screens/admin_homepage.dart';

class tydart extends StatefulWidget {
  const tydart({super.key});

  @override
  State<tydart> createState() => _tydartState();
}

class _tydartState extends State<tydart> {

   @override
  Widget build(BuildContext context) {
     size(context);
    return  Scaffold(  
      body: Center(  
        child: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminhome  ()));
          
        }, icon: Icon(Icons.abc))
      ), 
    ); 
  }
}