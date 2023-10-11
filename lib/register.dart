import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/constants.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:findee/login.dart';
import 'package:findee/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _signUpFormKey = GlobalKey<FormState>();

  //my code
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset('assets/FindeeLogoFinal.png'),
              const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xff8d6e63),
                    fontSize: 60,
                      fontWeight: FontWeight.bold,),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                key: _signUpFormKey,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //user name
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                        style: TextStyle(fontSize: 16),
                        decoration: const InputDecoration(hintText: "Username"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        autocorrect: true,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        style: TextStyle(fontSize: 16),
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //my code
                      //phone number
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 16),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^(?:[+0]9)?[0-9]{11}$');
                          if (value!.length == 0) {
                            return ("Please enter mobile number");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Please enter valid mobile number");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phoneController.text = value!;
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(11)],
                        decoration: const InputDecoration(
                          hintText: "Mobile number",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //password
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        style: TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //confirm password
                      TextFormField(
                        controller: confirmpassController,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (confirmpassController.text !=
                              passwordController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmpassController.text = value!;
                        },
                        style: TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: "Re-enter Password",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(16),
                                  textStyle: TextStyle(fontSize: 25),
                                  shape: StadiumBorder(),
                                  backgroundColor: kActiveIconColor,
                                ),
                                onPressed: () async {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    controller.isLoading(true);
                                    try {
                                      await controller
                                          .signupMethod(
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) {
                                        return controller.storeUserData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phoneNumber: phoneController.text,
                                        );
                                      }).then((value) {
                                        Fluttertoast.showToast(
                                          msg: "Account created successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        );
                                        Get.offAll(Navigation());
                                        controller.isLoading(false);
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      Fluttertoast.showToast(
                                        msg: e.toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 14,
                                      );
                                      controller.isLoading(false);
                                    }
                                  }
                                },
                                child: Text("Sign Up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white)),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLogin()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Have an account?",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
