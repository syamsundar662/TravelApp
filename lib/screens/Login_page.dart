import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trivo/database/functions/Firebase/fdb_functions.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/screens/admin/screens/admin_page.dart';
import 'package:trivo/screens/signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _gmailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        height: 200,
                        width: 500,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Hey Mate!',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Text(''),
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
                                  return 'Enter valid gmail.';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            gap,
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
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            gap,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (Context) => signUp()));
                                  },
                                  child: Container(
                                    width: screenWidth * .46,
                                    height: 52,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            width: .6)),
                                    child: const Align(
                                        child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    )),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () async {
                                //     _formkey.currentState!.validate();
                                //     setState(() {
                                //       loading = true;
                                //     });
                                //     loading
                                //         ? CircularProgressIndicator()
                                //         : checklog(context);
                                //     await f_authentication()
                                //         .signInWithEmailAndPassword(
                                //             _gmailcontroller.text,
                                //             _passwordcontroller.text,
                                //             context);
                                //     setState(() {
                                //       loading = false;
                                //     });
                                //   },
                                //   child: Container(
                                //     width: screenWidth * .46,
                                //     height: 52,
                                //     decoration: BoxDecoration(
                                //         color: Color.fromARGB(255, 0, 0, 0),
                                //         borderRadius:
                                //             BorderRadius.circular(10)),
                                //     child: const Align(
                                //         child: Text(
                                //       'Login',
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 20,
                                //           fontWeight: FontWeight.w300),
                                //     )),
                                //   ),
                                // ),
                                loading
                                    ? SizedBox(
                                        width: screenWidth * .46,
                                        height: 53,
                                        child: Expanded(
                                            child: RiveAnimation.asset(
                                                'assets/1326-2537-loading-dots.riv')),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(),
                                        width: screenWidth * .46,
                                        height: 53,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            _formkey.currentState!.validate();
                                            setState(() {
                                              loading = true;
                                            });
                                            checklog(context);
                                            await f_authentication()
                                                .signInWithEmailAndPassword(
                                                    _gmailcontroller.text,
                                                    _passwordcontroller.text,
                                                    context);
                                            setState(() {
                                              loading = false;
                                            });
                                          },
                                          child: Text('Login'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black),
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                        ),
                                      ),
                              ],
                            ),
                            gap,
                            gap,
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
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

  void checklog(context) async {
    final username = _gmailcontroller.text;
    final password = _passwordcontroller.text;
    if (username == 'admin' && password == '123') {
      print('match');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Adminhome(),
        ),
      );
    }
  }
}

// const error =
//     'Invalid gmail or password!';
// ScaffoldMessenger.of(context)
//     .showSnackBar(const SnackBar(
//         behavior:
//             SnackBarBehavior.floating,
//         backgroundColor: Color.fromARGB(
//             255, 238, 32, 32),
//         margin: EdgeInsets.all(20),
//         content: Text(error)));

//       InkWell(
//   onTap: () async {
//     _formkey.currentState!.validate();
//     setState(() {
//       loading = true;
//     });
//     loading
//         ? CircularProgressIndicator()
//         : checklog(context);
//     await f_authentication()
//         .signInWithEmailAndPassword(
//             _gmailcontroller.text,
//             _passwordcontroller.text,
//             context);
//     setState(() {
//       loading = false;
//     });
//   },
//   child: Container(
//     width: screenWidth * .46,
//     height: 52,
//     decoration: BoxDecoration(
//         color: Color.fromARGB(255, 0, 0, 0),
//         borderRadius:
//             BorderRadius.circular(10)),
//     child: const Align(
//         child: Text(
//       'Login',
//       style: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.w300),
//     )),
//   ),
// ),
