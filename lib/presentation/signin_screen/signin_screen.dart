import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bbb_app/core/app_export.dart';
import 'package:bbb_app/presentation/signin_screen/controller/signin_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../schedule_screen/controller/schedule_controller.dart';

class SignInScreen extends GetWidget<Signup02Controller> {
  //TextEditingController controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool showErrorMessage = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController(); //Define email controller
  final passwordController = TextEditingController();

  ConnectivityResult result = ConnectivityResult.none;

  late SharedPreferences prefs;
  late bool newuser;

  //Define email controller
  //TextEditingController mailController = new TextEditingController();
  //TextEditingController pawController = new TextEditingController();
  //var compasswordController = TextEditingController(); //Define email controller

  //SharedPreferences localStorage;

  //class MyApp extends StatelessWidget {
  // static Future init() async {
  //   localStorage = await SharedPreferences.getInstance();
  // }
  //bool isLoggedIn = false;

  String email = '';
  int id = 0;
  String firstName = '';
  String lastName = '';
  String phone = '';
  String role = '';
  String created = '';
  String updated = '';
  String jwtToken = '';
  bool isVerified = true;

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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), color: Colors.white),
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
                                    'Sign In', //Heading
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
                                padding:
                                const EdgeInsets.only(left: 16.0, bottom: 8.0),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: emailController,
                                  //calling Defined email controllor
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email';
                                    }
                                    if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return "Please Enter Valid Email";
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
                                      borderSide:
                                      BorderSide(color: Colors.lightBlueAccent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.lightBlueAccent),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 16.0, bottom: 8.0),
                                child: Obx(() => TextFormField(
                                  onFieldSubmitted: (value) {
                                    onTapBtnSignIn(context);
                                  },
                                  controller: passwordController,
                                  //calling Defined email controllor

                                  keyboardType: TextInputType.text,
                                  obscureText: controller
                                      .isPasswordVisibilityHidden.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                    return null;
                                  },

                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.isPasswordVisibilityHidden
                                              .value =
                                          !controller
                                              .isPasswordVisibilityHidden
                                              .value;
                                        },
                                        icon: Icon(
                                          controller.isPasswordVisibilityHidden
                                              .value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.lightBlueAccent,
                                        )),
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black45,
                                        fontStyle: FontStyle.italic),
                                    icon: Icon(Icons.lock,
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
                                )),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: Obx(() => ElevatedButton(
                                      onPressed: controller.isLoading.value
                                          ? null
                                          : () {
                                        onTapBtnSignIn(context);
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
                                              style:
                                              TextStyle(fontSize: 18))
                                        ],
                                      )
                                          : Text(
                                        'Sign In',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.lightBlueAccent),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20.0),
                                                  side: const BorderSide(
                                                      color:
                                                      Colors.lightBlueAccent)))),
                                    )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: <Widget>[
                                  const Text('Forgot Password '),
                                  TextButton(
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.lightBlueAccent),
                                    ),
                                    onPressed: () {
                                      onTapforgotpassword();
                                    },
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ));
  }

  // onTapImgMdiclose() {
  //   Get.toNamed(AppRoutes.onboardingScreen);
  // }
  //
  // onPressGroup9() {

  //   Get.toNamed(AppRoutes.dashboardScreen);
  // }
  onTapBtnSignIn(context) async {
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
        postDataLogin();
      } //Forgot password Api
    }
  }

  final url = "http://192.168.8.175:4000/accounts/authenticate";

  /**
   * This fuction use for login
   */
  void postDataLogin() async {
    controller.isLoading.value = true;

    try {
      final response = await post(Uri.parse(url), body: {
        "email": emailController.text,
        "password": passwordController.text
      }).timeout(
        const Duration(seconds: 5),
        onTimeout: () => http.Response(
          'timeout',
          408,
        ),
      );

      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          var parsedJson = json.decode(response.body);
          print('${parsedJson.runtimeType} : $parsedJson');
          firstName = parsedJson['firstName'];
          id = parsedJson['id'];
          lastName = parsedJson['lastName'];
          email = parsedJson['email'];
          phone = parsedJson['phone'];
          role = parsedJson['role'];
          created = parsedJson['created'];
          isVerified = parsedJson['isVerified'];
          jwtToken = parsedJson['jwtToken'];

          savePreferences(id, firstName, lastName, email, phone, role, created,
              isVerified, jwtToken);
          controller.isLoading.value = false;
          toastsuccessful();
          onTapgodashboard();

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
              msg: "Email or Password is Incorrect!",
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
        case 408:
          Fluttertoast.showToast(
              msg: "Request Timeout.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          controller.isLoading.value = false;
          break;
        default:
          toastunsuccessful();

          controller.isLoading.value = false;

          break;
      }
    } on TimeoutException catch (err) {
      Fluttertoast.showToast(
          msg: "Request Timeout.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      controller.isLoading.value = false;
      print(err);
    } on HttpException catch (err) {
      Fluttertoast.showToast(
          msg: "Http error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      controller.isLoading.value = false;
      print(err);
    } on SocketException catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Error: Socket Exception.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      controller.isLoading.value = false;
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Error during communicating the server.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      controller.isLoading.value = false;
    }
  }

  void toastsuccessful() => Fluttertoast.showToast(
      msg: "Successfully Login!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.lightBlueAccent,
      textColor: Colors.white,
      fontSize: 16.0);

  void toastunsuccessful() => Fluttertoast.showToast(
      msg: "Email or Password is Incorrect!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  onTapforgotpassword() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);
  }

  onTapgodashboard() {
    getRefreshMeetings();
    Get.toNamed(AppRoutes.dashboardScreen);
  }

  void savePreferences(
      int id,
      String firstName,
      String lastName,
      String email,
      String phone,
      String role,
      String created,
      bool isVerified,
      String jwtToken) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("user_id", id);
    prefs.setString("first_name", firstName);
    prefs.setString("last_name", lastName);
    prefs.setString("user_email", email);
    prefs.setString("phone_no", phone);
    prefs.setString("user_role", role);
    prefs.setString("role_created", created);
    prefs.setString("Token", jwtToken);
    prefs.setBool('isVerified', isVerified);

    print(email);
  }

  // saveToShared_Preferences() async {
  //   logindata = await SharedPreferences.getInstance();
  //   logindata.setString("email", emailController.text.toString());
  //   logindata.setString("paw", passwordController.text.toString());
  //   return saveToShared_Preferences();
  // }
  onTimeout() {
    Fluttertoast.showToast(
        msg: "Request Timeout.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    controller.isLoading.value = false;
  }

  getRefreshMeetings() {
    final controller = Get.put(ScheduleController());
    controller.getJsonData();
  }

  showSavedValue() async {
    prefs = await SharedPreferences.getInstance();

    //var save = logindata.getString("email").toString();
    //logindata.getString('email', email);
    // ignore: deprecated_member_use
    return prefs.commit();
  }
// saveToShared_Preferences()async {
//   //after the login REST api call && response code ==200
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('email', emailController.text.toString());
//   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => ProfileScreen()));
//}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences logindata = await SharedPreferences.getInstance();
//   var email = logindata.getString('email');
//   print(email);
//   runApp(MaterialApp(home: email == null ? Signup02Screen() : ProfileScreen()));
// }

}