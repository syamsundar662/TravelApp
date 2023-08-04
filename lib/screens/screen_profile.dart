import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_snackbars/enums/animate_from.dart';
import 'package:smart_snackbars/smart_snackbars.dart';
import 'package:trivo/database/functions/Firebase/db_userprofile.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/screens/admin/screens/admin_homepage.dart';
import 'package:trivo/screens/profile_section/screen_aboutus.dart';
import 'package:trivo/screens/profile_section/screen_contactus.dart';
import 'package:trivo/screens/profile_section/screen_privacypolicy.dart';
import 'package:trivo/screens/profile_section/screen_termsandconditions.dart';
import 'package:trivo/widgets/w_signout.dart';

String umail = '';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _image;
  Map<String, dynamic>? querySnapshotData;
  ProfileFirebase url = ProfileFirebase();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    setState(() {
      url.getuserimage();
      url.imageURLdb;
    });
  }

  getCurrentUser() async {
    final User? user = _auth.currentUser;
    setState(() {
      umail = user!.email!;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> userNameFromMailId = umail.split('@');
    String userName = userNameFromMailId[0];
    String profilename =
        userName[0].toUpperCase() + userName.substring(1).toLowerCase();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Adminhome())),
            child: const Text(
              'Profile',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: .2,
          actions: [
            TextButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await url.saveProfile(_image);
                  setState(() {
                    loading = false;
                  });

                  await url.getuserimage();
                  setState(() {
                    url.imageURLdb;

                    {
                      SmartSnackBars.showCustomSnackBar(
                        context: context,
                        duration: const Duration(milliseconds: 1800),
                        animateFrom: AnimateFrom.fromBottom,
                        distanceToTravel: 25,
                        outerPadding: const EdgeInsets.all(0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.fromLTRB(16, 10, 23, 10),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 0, 49, 122),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Your changes have been saved",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  });
                },
                child: loading
                    ? const CupertinoActivityIndicator()
                    : const Text('Done'))
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: SizedBox(
              child: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          insetPadding:
                                              const EdgeInsets.all(40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Container(
                                            height: 300,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      await _pickImage();
                                                    },
                                                    child: url.imageURLdb !=
                                                            null
                                                        ? CircleAvatar(
                                                            radius: 80,
                                                            backgroundImage:
                                                                CachedNetworkImageProvider(
                                                                    url.imageURLdb!),
                                                          )
                                                        : _image != null
                                                            ? CircleAvatar(
                                                                radius: 80,
                                                                backgroundImage:
                                                                    FileImage(
                                                                        _image!))
                                                            : CircleAvatar(
                                                                radius: 80,
                                                                child: Image.asset(
                                                                    'assets/profile-icon-design-free-vector (1).jpg')),
                                                  ),
                                                  gap,
                                                  Text(umail)
                                                ],
                                              ),
                                            ),
                                          ));
                                    });
                              });
                            },
                            child: url.imageURLdb != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: CachedNetworkImageProvider(
                                        url.imageURLdb!),
                                  )
                                : _image != null
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundImage: FileImage(_image!))
                                    : CircleAvatar(
                                        radius: 60,
                                        child: Image.asset(
                                            'assets/profile-icon-design-free-vector (1).jpg')),
                          ),
                        ),
                        Text(
                          profilename,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25),
                        ),
                        Text(umail),
                        TextButton(
                          onPressed: () async {
                            url.imageURLdb = null;
                            await _pickImage();
                          },
                          child: const Text('Add or edit avatar'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactUsPage())),
                            child: const Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const Text(''),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermsAndConditionsPage())),
                            child: const Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const Text(''),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolict())),
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const Text(''),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutUsPage())),
                            child: const Text(
                              'About Us',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const Text(''),
                          InkWell(
                            onTap: () async {
                              await signout(context);
                              setState(() {});
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text('Version 1.0')],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
