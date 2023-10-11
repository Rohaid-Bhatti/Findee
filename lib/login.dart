import 'package:findee/constants.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:findee/home.dart';
import 'package:findee/register.dart';
import 'package:findee/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //my code
  final _loginFormKey = GlobalKey<FormState>();
  var controller = Get.put(AuthController());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
             Image.asset('assets/FindeeLogoFinal.png'),

              const Text('Login',
                  style: TextStyle(
                      color: Color(0xff8d6e63),
                      fontSize: 60,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 70,
              ),

              Form(
                key: _loginFormKey,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        autocorrect: true,

                        //my code
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Your Email");
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

                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 18,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,

                        //my code
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password");
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },

                        style: TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_outline, size: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(16),
                                  textStyle: TextStyle(fontSize: 16),
                                  shape: StadiumBorder(),
                                  backgroundColor: kActiveIconColor,
                                ),
                                onPressed: () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    controller.isLoading(true);
                                    await controller
                                        .loginMethod(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    )
                                        .then((value) {
                                      if (value != null) {
                                        Fluttertoast.showToast(
                                          msg: "Logged in successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        );
                                        Get.offAll(Navigation());
                                        //checking
                                        controller.isLoading(false);
                                      } else {
                                        controller.isLoading(false);
                                      }
                                    });
                                  }
                                },
                                child: const Text("Log In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white)),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyRegister()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?", style: TextStyle(fontSize: 16)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              /*GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Admin_Panel()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Are you an Admin? ", style: TextStyle(fontSize: 16)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),*/

            ],
          ),
        ]),
      ),
    );
  }
}
