import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/fdb_functions.dart';
import 'package:trivo/helper/size.dart';

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
                        height: 190,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _gmailcontroller,
                              decoration: InputDecoration(
                                  fillColor: Color.fromARGB(0, 216, 137, 158),
                                  hintText: 'Gmail',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // borderSide: BorderSide.none,
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
                                fillColor: Color.fromARGB(0, 216, 137, 158),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // borderSide: BorderSide.none,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    f_authentication().createGmailandPassword(
                                        _gmailcontroller.text,
                                        _passwordcontroller.text,
                                        context);
                                  },
                                  child: Container(
                                    width: screenWidth * .46,
                                    height: 52,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            width: .6)),
                                    child: const Align(
                                        child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
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
