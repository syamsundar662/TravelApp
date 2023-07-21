import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/lists/list_districts.dart';
import 'package:trivo/lists/list_categories.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';

bool isListEmpty = true;
bool load = false;
// XFile? images;
// File? _image;

class AddPlaces extends StatefulWidget {
  const AddPlaces({
    super.key,
  });

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  final formkey = GlobalKey<FormState>();

  String? selectedDistrictvalue;
  String? selectedCategoryvalue;

  final placeNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final reachthereController = TextEditingController();

  Repository repos = Repository();

  final picker = ImagePicker();
  List<XFile> pickedImages = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Repository().getalldatas();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Repository().getalldatas();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Add Details'),
          ),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: placeNameController,
                      decoration: InputDecoration(
                          hintText: 'Place name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            // borderSide: BorderSide.,
                          ),
                          filled: true),
                    ),
                    verticalGap1,
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'Location(Link)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    //drop do
                    verticalGap1,
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Select district',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      value: selectedDistrictvalue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDistrictvalue = newValue;
                        });
                      },
                      items: districts.map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                    ),

                    //           //district dropdown

                    //           //             //category dropdown
                    verticalGap1,
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Select category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      value: selectedCategoryvalue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategoryvalue = newValue;
                        });
                      },
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                    ),
                    verticalGap1,
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    verticalGap1,
                    TextField(
                      controller: reachthereController,
                      decoration: InputDecoration(
                        hintText: 'Other info',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          multiImagePicker();
                        },
                        icon: const Icon(Icons.image)),
                    ElevatedButton(
                        onPressed: () async {
                          submitChecking(context);
                        },
                        child: const Text('submit'))
                  ],
                ),
              ),
            ),
          )),
    );
  }

//===========android==========
  pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }
//android

// ==========ios===========
  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedImage != null) {
  //       _image = File(pickedImage.path);
  //     }
  //   });
  // }
//ios

//========Multiple image picker==========
  Future<void> multiImagePicker() async {
    final selectedFiles = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    // ignore: unnecessary_null_comparison
    if (selectedFiles != null && selectedFiles.isNotEmpty) {
      setState(() {
        pickedImages = selectedFiles;
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No images selected')));
    }
  }

  void submitChecking(BuildContext context) async {
    Repository().getalldatas();

    if (placeNameController.text.isEmpty ||
        locationController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        pickedImages.isEmpty ||
        reachthereController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
        ),
      );
    } else {
      List<File> selectedpick = [];
      List<String> selectedpickpath = [];
      // selectedpickpath.addAll(pickedImages.map((file) => file.path).toList());
      // ignore: avoid_function_literals_in_foreach_calls
      pickedImages.forEach((element) {
        selectedpickpath.add(File(element.path).path);
      });
      // ignore: avoid_function_literals_in_foreach_calls
      pickedImages.forEach((element) {
        selectedpick.add(File(element.path));
      });
      final destination = DestinationFB(
          placeName: placeNameController.text,
          location: locationController.text,
          description: descriptionController.text,
          reachthere: reachthereController.text,
          image: selectedpickpath,
          district: selectedDistrictvalue!,
          category: selectedCategoryvalue!);

      await repos.fb_addDestination(destination);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text('Added successfully')));
      clearform();
    }
  }

  clearform() {
    placeNameController.clear();
    descriptionController.clear();
    locationController.clear();
    reachthereController.clear();
    setState(() {
      selectedCategoryvalue = null;
      selectedDistrictvalue = null;
    });
  }
}
