import 'package:flutter/material.dart';

late double screenHeight;
late double screenWidth;

void size(BuildContext context){
  screenHeight =  MediaQuery.of(context).size.height;
  screenWidth =  MediaQuery.of(context).size.width;
}


 const gap = SizedBox(height: 10,);
 const gapW5 = SizedBox(width: 5,);
 const verticalGap1 = SizedBox(height: 7,);
 const verticalGap2 = SizedBox(height: 20,);
 const verticalGap3 = SizedBox(height: 30,);
 const verticalGap4 = SizedBox(height: 40);
 const verticalGap5 = SizedBox(height: 50,);
 const verticalGap6 = SizedBox(height: 60,); 
 