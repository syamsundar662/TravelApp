// import 'package:flutter/material.dart';
// import 'package:trivo/lists/districts.dart';

// class Searchpage extends StatefulWidget {
//   const Searchpage({super.key});

//   @override
//   State<Searchpage> createState() => _SearchpageState();
// }

// class _SearchpageState extends State<Searchpage> {
//   @override
//   Widget build(BuildContext context) {
//     var selectedDistrictvalue;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   hintText: 'Select district',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                 ),
//                 value: selectedDistrictvalue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedDistrictvalue = newValue;
//                   });
//                 },
//                 items: districts.map((String district) {
//                   return DropdownMenuItem<String>(
//                     value: district,
//                     child: Text(district),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/lists/category.dart';

class Searchpage extends StatefulWidget {
  Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment(-.95, 0),
              child: Text('Select Categories')),
            Container(
              height: screenHeight * .07,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected= !selected;
                        });
                      },
                      child: Container(
                        child: Align(child: Text(categories[index])),
                        width: screenWidth * .2,
                        decoration: selected? BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(10)):BoxDecoration(
                          color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment(-.95, 0),
              child: Text('Select Districts')),
            Container(
              height: screenHeight * .07,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: Align(child: Text(categories[index])),
                      width: screenWidth * .2,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
