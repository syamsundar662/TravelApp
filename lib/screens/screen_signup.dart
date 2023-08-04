// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/authentication/db_authentication.dart';
import 'package:trivo/helper/helper_size.dart';

// ignore: must_be_immutable
class signUp extends StatelessWidget {
  signUp({super.key});

  final _gmailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool done = false;

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
                                  return 'Enter valid gmail.';
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
                                  return 'Enter your password.';
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
                                    await F_authentication()
                                        .createGmailandPassword(
                                            _gmailcontroller.text,
                                            _passwordcontroller.text,
                                            context);
                                  },
                                  child: Container(
                                    width: screenWidth * .937,
                                    height: 53,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          177, 10, 124, 162),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Align(
                                        child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
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
