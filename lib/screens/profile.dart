// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:trivo/screens/Login_page.dart';
import 'package:trivo/widgets/showdialogue.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Column(
              children: [
                Align(
                  child: CircleAvatar(
                    radius: 60,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 120,
                    ),
                  ),
                ),
                Text(
                  'Syam Sundar',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                ),
                // Text('9072200430'),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 56, 56, 56),
                        fontWeight: FontWeight.w200),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(''),
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 56, 56, 56),
                        fontWeight: FontWeight.w200),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(''),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 56, 56, 56),
                        fontWeight: FontWeight.w200),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(''),
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 56, 56, 56),
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          signout(context);
                        },
                        child: const Text('Logout'),
                      )),
                  const Text('Version 1.0')
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

 
}
