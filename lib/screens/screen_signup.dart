// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/db_authentication.dart';
import 'package:trivo/helper/helper_size.dart';

class signUp extends StatelessWidget {
  signUp({super.key});

  final _gmailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalGap6,
                verticalGap6,
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * .18,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            verticalGap5,
                            TextFormField(
                              controller: _gmailcontroller,
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(98, 203, 204, 206),
                                  hintText: 'Gmail',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter valid username.';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _passwordcontroller,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(98, 203, 204, 206),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter valid password.';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            gap,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _formkey.currentState!.validate();
                                    F_authentication().createGmailandPassword(
                                        _gmailcontroller.text,
                                        _passwordcontroller.text,
                                        context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            backgroundColor: Color.fromARGB(
                                                177, 10, 124, 162),
                                            content:
                                                Text('Successfully Created')));
                                  },
                                  child: Container(
                                    width: screenWidth * .937,
                                    height: 53,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          177, 10, 124, 162),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(width: .6)
                                    ),
                                    child: const Align(
                                        child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                      // style: TextStyle(
                                      //     color: Colors.white,
                                      //     fontSize: 20,
                                      //     fontWeight: FontWeight.w300),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
