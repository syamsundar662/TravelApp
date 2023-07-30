import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivo/database/functions/Firebase/profile.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/widgets/w_showdialogue.dart';

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
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

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
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontSize: 20),
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
                  });
                },
                child: loading ? const CupertinoActivityIndicator() : const Text('Done'))
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
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
                                    insetPadding: const EdgeInsets.all(40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Container(
                                      height: 300,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
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
                                              child: url.imageURLdb != null
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
                              backgroundImage:
                                  CachedNetworkImageProvider(url.imageURLdb!),
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
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 56, 56, 56),
                          fontWeight: FontWeight.w200),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(''),
                    const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 56, 56, 56),
                          fontWeight: FontWeight.w200),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(''),
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 56, 56, 56),
                          fontWeight: FontWeight.w200),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(''),
                    const Text(
                      'About Us',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 56, 56, 56),
                          fontWeight: FontWeight.w200),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text(''),
                    InkWell(
                      onTap: () {
                        signout(context);
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
    );
  }
}
