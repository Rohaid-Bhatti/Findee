/*
import 'dart:io';
import 'package:findee/constants.dart';
import 'package:findee/controllers/profile_controller.dart';
import 'package:findee/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final dynamic data;

  const EditProfilePage({Key? key, this.data}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  */
/*late File _image;
  final picker = ImagePicker();*/ /*

  var controller1 = Get.put(ProfileController());
  var controller = Get.find<ProfileController>();

  */
/*Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }*/ /*


  @override
  Widget build(BuildContext context) {
    controller.nameController.text = widget.data['name'];
    controller.emailController.text = widget.data['email'];
    controller.phoneController.text = widget.data['phoneNumber'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveIconColor,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: */
/*getImage*/ /*
() {
                  controller.changeImage();
                },
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: widget.data['image'] == '' &&
                        controller.profileImgPath.isEmpty
                        ? const Image(
                      image: AssetImage('assets/images/user.png'),
                    )
                        : widget.data['image'] != '' &&
                        controller.profileImgPath.isEmpty
                        ? Image.network(widget.data['image'])
                        : Image.file(
                      File(controller.profileImgPath.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                */
/*CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                  _image != null
                      ? FileImage(_image)
                      : NetworkImage(
                      'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50'),
                      AssetImage('assets/images/user.png'),
                ),*/ /*

              ),
              SizedBox(height: 16),
              TextFieldWidget('Name', controller.nameController),
              SizedBox(height: 16),
              TextFieldWidget('Email', controller.emailController),
              SizedBox(height: 16),
              TextFieldWidget('Phone Number', controller.phoneController),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kActiveIconColor,
                ),
                onPressed: () async {
                  controller.isLoading(true);
                  // Save changes to Firestore or other storage
                  if (controller.profileImgPath.value.isNotEmpty) {
                    await controller.uploadProfileImage();
                  } else {
                    controller.profileImageLink = widget.data['image'];
                  }

                  await controller.updateProfile(
                    image: controller.profileImageLink,
                    name: controller.nameController.text,
                    email: controller.emailController.text,
                    phoneNumber: controller.phoneController.text,
                  );
                  Fluttertoast.showToast(msg: "Update successfully");
                },
                child: Text('Save Changes'),
              )   ,
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:findee/constants.dart';
import 'package:findee/controllers/profile_controller.dart';
import 'package:findee/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final dynamic data;

  const EditProfilePage({Key? key, this.data}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var controller1 = Get.put(ProfileController());
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.nameController.text = widget.data['name'];
    controller.emailController.text = widget.data['email'];
    controller.phoneController.text = widget.data['phoneNumber'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kActiveIconColor,
        title: Text(
          "Profile",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.all(16),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            GestureDetector(
              onTap: () {
                controller.changeImage();
              },
              child: Center(
                child: Stack(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.data['image'] == '' &&
                                controller.profileImgPath.isEmpty
                            ? Image(
                                image: AssetImage('assets/images/user.png'),
                              )
                            : widget.data['image'] != '' &&
                                    controller.profileImgPath.isEmpty
                                ? Image.network(widget.data['image'])
                                : Image.file(
                                    File(controller.profileImgPath.value),
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFieldWidget("Full Name", controller.nameController),
            SizedBox(height: 15),
            TextFieldWidget("Email", controller.emailController),
            SizedBox(height: 15),
            TextFieldWidget("Phone Number", controller.phoneController),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kActiveIconColor,
              ),
              onPressed: () async {
                controller.isLoading(true);

                //if image is not selected
                if (controller.profileImgPath.value.isNotEmpty) {
                  await controller.uploadProfileImage();
                } else {
                  controller.profileImageLink = widget.data['image'];
                }

                await controller.updateProfile(
                  image: controller.profileImageLink,
                  name: controller.nameController.text,
                  email: controller.emailController.text,
                  phoneNumber: controller.phoneController.text,
                );
                Fluttertoast.showToast(msg: "Updated");
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
