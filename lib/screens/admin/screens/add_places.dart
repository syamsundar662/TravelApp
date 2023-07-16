
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/lists/districts.dart';
import 'package:trivo/lists/category.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';

bool isListEmpty = true;
// XFile? images;
// File? _image;

class AddPlaces extends StatefulWidget {
  const AddPlaces({super.key});

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
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Details'),
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
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
                        onPressed: () {
                          submitChecking(context);
                        },
                        child: const Text('submit'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

//===========android==========
  pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return  image;
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
        // pickedImages
        //     .addAll((selectedFiles.map((pickedFile) => File(pickedFile.path))));
        pickedImages=selectedFiles;
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No images selected')));
    }
  }

  void submitChecking(BuildContext context) {
    if (placeNameController.text.isEmpty ||
        locationController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        pickedImages.isEmpty ||
        reachthereController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('error'),
        ),
      );
    } else {
      // List<String> selectedpickpath = [];
      // selectedpickpath.addAll(pickedImages.map((file) => file.path).toList());

      final destination = DestinationFB(
          placeName: placeNameController.text,
          location: locationController.text,
          description: descriptionController.text,
          reachthere: reachthereController.text,
          image: pickedImages,
          district: selectedDistrictvalue!,
          category: selectedCategoryvalue!);

      repos.fb_addDestination(destination);
    }
  }
}
