import 'dart:io';

import 'package:findee/constants.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:findee/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateAd extends StatefulWidget {
  const CreateAd({Key? key}) : super(key: key);

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  var controller = Get.put(AuthController());
  final _form = GlobalKey<FormState>();

  String dropdownvalue = 'Humans';
  var items = [
    'Humans',
    'Animals',
    'Documents',
    'Electronics',
    'Vehicles',
    'Others'
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();
  String? _selectedImagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kActiveIconColor,
        title: const Text(
          "Create Ads",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Image',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    _selectImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    color: Colors.grey[300],
                    child: _selectedImagePath != null
                        ? Image.file(
                            File(_selectedImagePath!),
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(Icons.image, size: 80.0),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _nameController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter the name of ad',
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                DropdownButton(
                  value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                const Text(
                  'Rewards',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter Reward';
                    }
                    return null;
                  },
                  controller: _rewardController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter the reward',
                  ),
                ),
                const SizedBox(height: 30.0),
                const SizedBox(height: 30.0),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter description';
                    }
                    return null;
                  },
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a description',
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Number',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter number';
                    }
                    return null;
                  },
                  controller: _numberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter a number',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      kActiveIconColor, // Set your desired background color here
                    ),
                  ),
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationScreen(
                                    name: _nameController.text,
                                    desc: _descriptionController.text,
                                    number: _numberController.text,
                                    reward: _rewardController.text,
                                    category: dropdownvalue,
                                    image: _selectedImagePath,
                                  )));
                    }
                    // TODO: Implement form submission logic
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
