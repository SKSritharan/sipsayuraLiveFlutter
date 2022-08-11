import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bbb_app/core/app_export.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'controller/signup_controller.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends GetWidget<Signup04Controller> {
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool showErrorMessage = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var fnameController = TextEditingController(); //Define email controller
  var lnameController = TextEditingController(); //Define email controller
  var phoneController = TextEditingController(); //Define email controller
  var emailController = TextEditingController(); //Define email controller
  var passwordController = TextEditingController(); //Define email controller
  var compasswordController = TextEditingController(); //Define email controller

  ConnectivityResult result = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: new AppBar(
              backgroundColor: Colors.lightBlueAccent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "lbl_sipsayura2".tr,
                        style: TextStyle(
                            color: ColorConstant.whiteA700,
                            fontSize: getFontSize(18),
                            fontFamily: 'Oldenburg',
                            fontWeight: FontWeight.w500)),
                  ]),
                  textAlign: TextAlign.left),
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black54),
            ),
            body: GetBuilder<Signup04Controller>(builder: (Signup04Controller) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: Colors.white),
                    child: Center(
                      child: SafeArea(
                        left: false,
                        top: false,
                        right: false,
                        bottom: false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    child: Center(
                                      child: Text(
                                        'Sign Up', //Heading
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller:
                                          fnameController, //calling Defined email controllor
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter First Name';
                                        } else if (!RegExp(r"^[a-zA-Z]+$")
                                            .hasMatch(value)) {
                                          return 'Please enter valid Characters';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "First Name",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45,
                                            fontStyle: FontStyle.italic),
                                        icon: Icon(Icons.person,
                                            color: Colors.lightBlueAccent),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller:
                                          lnameController, //calling Defined email controllor

                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Last Name';
                                        } else if (!RegExp(r"^[a-zA-Z]+$")
                                            .hasMatch(value)) {
                                          return 'Please enter valid Last Name';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Last Name",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45,
                                            fontStyle: FontStyle.italic),
                                        icon: Icon(Icons.person,
                                            color: Colors.lightBlueAccent),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller:
                                          phoneController, //calling Defined email controllor

                                      keyboardType: TextInputType.number,

                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Phone No';
                                        } else if (!RegExp(
                                                r'(^(?:[+0]9)?[0-9]{10}$)')
                                            .hasMatch(value)) {
                                          return 'Please enter valid mobile number';
                                        }
                                        return null;
                                      },

                                      decoration: const InputDecoration(
                                        labelText: "Phone No",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45,
                                            fontStyle: FontStyle.italic),
                                        icon: Icon(Icons.phone,
                                            color: Colors.lightBlueAccent),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller:
                                          emailController, //calling Defined email controllor

                                      keyboardType: TextInputType.text,

                                      //validation of email
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Email';
                                        }
                                        if (!RegExp(
                                                r"^[a-zA-Z0-9+_.-]+@[a-zA-Z]+\.[a-zA-Z]+$")
                                            .hasMatch(value)) {
                                          return "Please Enter Valid Email.";
                                        }
                                        return null;
                                      },

                                      decoration: const InputDecoration(
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black45,
                                            fontStyle: FontStyle.italic),
                                        icon: Icon(Icons.mail,
                                            color: Colors.lightBlueAccent),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: Obx(() => TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller:
                                              passwordController, //calling Defined email controllor

                                          keyboardType: TextInputType.text,
                                          obscureText: controller
                                              .isPasswordVisibilityHidden.value,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Password';
                                            }
                                            if (value.length < 6) {
                                              return 'Password is too short.';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                controller
                                                        .isPasswordVisibilityHidden
                                                        .value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              onPressed: () {
                                                controller
                                                        .isPasswordVisibilityHidden
                                                        .value =
                                                    !controller
                                                        .isPasswordVisibilityHidden
                                                        .value;
                                              },
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black45,
                                                fontStyle: FontStyle.italic),
                                            icon: Icon(Icons.lock,
                                                color: Colors.lightBlueAccent),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: Obx(() => TextFormField(
                                          onFieldSubmitted: (value) {
                                            onTapBtnSignUp(context);
                                          },
                                          // textInputAction: TextInputAction.next,
                                          controller:
                                              compasswordController, //calling Defined email controllor
                                          keyboardType: TextInputType.text,
                                          obscureText: controller
                                              .isConfirmPasswordVisibilityHidden
                                              .value,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Password';
                                            } else if (value !=
                                                passwordController.text)
                                              return 'Confirm password not match with password';
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Confirm Password",
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                controller
                                                        .isConfirmPasswordVisibilityHidden
                                                        .value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              onPressed: () {
                                                controller
                                                        .isConfirmPasswordVisibilityHidden
                                                        .value =
                                                    !controller
                                                        .isConfirmPasswordVisibilityHidden
                                                        .value;
                                              },
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black45,
                                                fontStyle: FontStyle.italic),
                                            icon: Icon(Icons.lock,
                                                color: Colors.lightBlueAccent),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          width: 150,
                                          child: Obx(
                                            () => ElevatedButton(
                                              onPressed: controller
                                                      .isLoading.value
                                                  ? null
                                                  : () async {
                                                      onTapBtnSignUp(context);
                                                    },
                                              child: controller.isLoading.value
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text("Please wait",
                                                            style: TextStyle(
                                                                fontSize: 16))
                                                      ],
                                                    )
                                                  : Text(
                                                      'Sign Up',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(Colors
                                                          .lightBlueAccent),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(20.0),
                                                          side: const BorderSide(color: Colors.lightBlueAccent)))),
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })));
  }

  // onTapImgMdiclose() {
  //   Get.toNamed(AppRoutes.onboardingScreen);
  // }
  //
  // onPressGroup9() {
  //   Get.toNamed(AppRoutes.dashboardScreen);
  // }

  /**
   * singup http request
   */
  onTapBtnSignUp(context) async {
    result = await Connectivity().checkConnectivity();
    if (_formKey.currentState!.validate()) {
      if (result == ConnectivityResult.none) {
        AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.ERROR,
          showCloseIcon: false,
          title: "Oops!",
          desc: 'No Internet Connection found Check your connection',
          btnOkOnPress: () {
            // Navigator.pop(context);
          },
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: (type) {
            debugPrint('Dialog Dismiss from callback $type');
          },
        ).show();
      } else {
        sing_up(); //Forgot password Api
      }
    }
  }

  final url = "http://192.168.8.175:4000/accounts/egister";
  void sing_up() async {
    controller.isLoading.value = true;
    try {
      final response = await post(Uri.parse(url), body: {
        "firstName": fnameController.text,
        "lastName": lnameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "confirmPassword": compasswordController.text,
        "acceptTerms": "true"
      });
      print(response.body);

      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          var responseText = jsonDecode(response.body);
          controller.isLoading.value = false;
          if (responseText["message"] ==
              "Email and Phone number is already registered.") {
            toastEmailAndPhoneNumberAllReadyExist();
            // controller.isEmailUnique.value =false;
            // controller.isPhoneUnique.value =false;
          } else if (responseText["message"] ==
              "Email is already registered.") {
            toastEmailAllReadyExist();
            // controller.isEmailUnique.value =false;
            // controller.isPhoneUnique.value =true;
          } else if (responseText["message"] ==
              "Phone number is already registered.") {
            toastPhoneNumberAllReadyExist();
            // controller.isPhoneUnique.value =false;
            // controller.isEmailUnique.value =true;
          } else if (responseText["message"].contains('Can\'t send mail')) {
            toastEmailNotValid();
            // controller.isEmailValid.value=false;
          } else {
            controller.isLoading.value = false;
            toastSuccessful();
            emailVerify();
          }
          break;
        case 500:
          Fluttertoast.showToast(
              msg: "Internal Server Error.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          controller.isLoading.value = false;
          break;
        case 503:
          Fluttertoast.showToast(
              msg: "Service Unavailable.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          controller.isLoading.value = false;

          break;
        case 400:
          Fluttertoast.showToast(
              msg: "Bad Request.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          controller.isLoading.value = false;
          break;
        case 404:
          Fluttertoast.showToast(
              msg: "The server can not find the requested resource.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          controller.isLoading.value = false;
          break;
        default:
          Fluttertoast.showToast(
              msg: "Something went wrong please try again later.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          controller.isLoading.value = false;

          break;
      }

      // toastSuccessful();
      // Emailverfy();
    } catch (err) {
      controller.isLoading.value = false;
      // toastUnsuccessful();

    }
  }

  /**
   * toast message for succesfully Register
   */
  void toastSuccessful() => Fluttertoast.showToast(
      msg: "Register Successful.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.lightBlueAccent,
      textColor: Colors.white,
      fontSize: 16.0);

  /**
   * toast message for register fail
   */
  void toastUnsuccessful() => Fluttertoast.showToast(
      msg: "Register Unsuccessful.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  void toastEmailAllReadyExist() => Fluttertoast.showToast(
      msg: "The Email is already registered.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  void toastPhoneNumberAllReadyExist() => Fluttertoast.showToast(
      msg: "The Phone number is already registered.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  void toastEmailAndPhoneNumberAllReadyExist() => Fluttertoast.showToast(
      msg: "The Email & Phone is already registered.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  void toastEmailNotValid() => Fluttertoast.showToast(
      msg: "The Email is not valid.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  emailVerify() {
    Get.toNamed(AppRoutes.emailVerifyScreen);
  }
}
