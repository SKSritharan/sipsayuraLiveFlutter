import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../schedule_screen/controller/schedule_controller.dart';
import '../models/schedule_meeting_bind.dart';
import '../models/schedule_model.dart';
import '/core/app_export.dart';
import 'package:flutter/material.dart';

class ScheduleMeetingFormController extends GetxController {
  resetForm() {
    topictxtController.clear();
    passcodeController.clear();
    participantstxtController.clear();
    isMeetingIDState = false;
  }

  var userName;
  var maxParticipantLimit = 100;

  TextEditingController topictxtController = TextEditingController();
  TextEditingController participantstxtController = TextEditingController();
  TextEditingController passcodeController = TextEditingController();

  putUserMeeting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString("last_name");

    userName = '${name}\'s Meeting';
    final password = generatePassword();
    isMeetingIDState = true;
    topictxtController.text = userName.toString();
    participantstxtController.text = maxParticipantLimit.toString();
    passcodeController.text = password.toString();
  }

  String meetingId = "";
  String passcode = "";
  var responseMsg = "";
  var responseText = "".obs;
  var isLoading = false.obs;

  var isResponseSuccess = false.obs;
  var apiResponse = "".obs;

  var selectedDate = DateTime.now().obs;
  var selectedStartTime = TimeOfDay.now().obs;
  var selectedEndTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 30))).obs;

  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = false,
  }) {
    final length = 8;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  // final selectedDuration = '15 Minutes'.obs;
  // final durations = ['15 Minutes', '30 Minutes', '45 Minutes', '60 Minutes'];

  // void setSelectedDuration(String value) {
  //   selectedDuration.value = value;
  //   update();
  // }

  // final selectedPartcipantCount = '20'.obs;
  // final partcipantCount = ['20', '30', '50', '80'];

  // void setSelectedpartcipantCount(String value) {
  //   selectedPartcipantCount.value = value;
  //   update();
  // }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        helpText: 'Select a Date for meeting',
        initialDate: selectedDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      update();
    }
  }

  chooseStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      helpText: 'Select a start time for meeting',
    );
    if (pickedTime != null && pickedTime != selectedStartTime.value) {
      selectedStartTime.value = pickedTime;
      update();
    }
  }

  chooseEndTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      // initialTime: selectedEndTime.value,
      initialTime: TimeOfDay.fromDateTime(DateTime(
              selectedDate.value.year,
              selectedDate.value.month,
              selectedDate.value.day,
              selectedStartTime.value.hour,
              selectedStartTime.value.minute)
          .add(Duration(minutes: 30))),
      helpText: 'Select a end time for meeting',
    );
    if (pickedTime != null && pickedTime != selectedEndTime.value) {
      // if (("${pickedTime.hour}:${pickedTime.minute}").compareTo(
      //         "${selectedStartTime.value.hour}:${selectedStartTime.value.minute}") <
      //     1) {
      if (DateFormat("yyyy-MM-dd hh:mm")
          .parse(
              '${selectedDate.value.toString()} ${selectedEndTime.value.toString()} ')
          .isBefore(DateFormat("yyyy-MM-dd hh:mm").parse(
              '${selectedDate.value.toString()} ${selectedStartTime.value.toString()} '))) {
        Fluttertoast.showToast(
            msg: "Invalid end time selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        selectedEndTime.value = TimeOfDay.fromDateTime(DateTime(
                selectedDate.value.year,
                selectedDate.value.month,
                selectedDate.value.day,
                selectedStartTime.value.hour,
                selectedStartTime.value.minute)
            .add(Duration(minutes: 30)));
      } else {
        selectedEndTime.value = pickedTime;
        update();
      }
    }
  }

  bool isMeetingIDState = true;

  void isAutoGenerated(bool? value) {
    isMeetingIDState = value!;
    final password = generatePassword();
    if (isMeetingIDState == true) {
      passcodeController.text = password.toString();
      update();
    } else if (isMeetingIDState == false) {
      passcodeController.clear();
      update();
    }
    update();
  }

  bool isAutoRecordingState = false;

  void isAutoRecording(bool? value) {
    isAutoRecordingState = value!;
    update();
  }

  bool isModeratorOnlyMessageState = false;

  void isModeratorOnlyMessage(bool? value) {
    isModeratorOnlyMessageState = value!;
    update();
  }

  bool isMuteOnStartState = false;

  void isMuteOnStart(bool? value) {
    isMuteOnStartState = value!;
    update();
  }

  bool isWebCamOnlyForModeratorState = false;

  void isWebCamOnlyForModerator(bool? value) {
    isWebCamOnlyForModeratorState = value!;
    update();
  }

  Rx<ScheduleModel> scheduleModelObj = ScheduleModel().obs;
  var meetings = <ScheduleMeetingBind>[].obs;

  void apiConnect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String token = prefs.getString("Token")!;
    isResponseSuccess.value = false;
    isLoading.value = true;
    print(token);
    try {
      Uri url = Uri.parse("http://192.168.8.175:4000/meetings/createMeeting");
      final response = await http.post(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, HEAD",
        "Access-Control-Allow-Credentials": "true",
        "authorization": "Bearer ${token}",
      }, body: {
        'name': topictxtController.text
            .replaceAll(' ', '%20')
            .replaceAll('\'', '%27'),
        'attend_pw': passcodeController.text,
        // 'max_participant':
        //     selectedPartcipantCount.value.replaceAll(RegExp("[]"), ""),
        'max_participant': participantstxtController.text,
        // 'max_duration':
        //     (selectedDuration.value.replaceAll(RegExp("[ Minutes]"), "")),
        // 'max_duration': duration.value,
        'start_date':
            DateFormat("yyyy-MM-dd").format(selectedDate.value).toString(),
        'selected_start_time':
            "${selectedStartTime.value.hour}:${selectedStartTime.value.minute}",
        'selected_end_time':
            "${selectedEndTime.value.hour}:${selectedEndTime.value.minute}",
        'auto_start_recording': isAutoRecordingState.toString(),
        'lock_settings_disable_public_chat':
            isModeratorOnlyMessageState.toString(),
        'mute_on_start': isMuteOnStartState.toString(),
        'allow_mods_to_eject_cameras': isWebCamOnlyForModeratorState.toString()
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response(
          '{"statusCode":"408"}',
          408,
        ),
      );
      var parsedJson = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          final responseMsg = Response.fromJson(parsedJson);
          responseText.value = (responseMsg.status);
          getRefreshMeetings();
          apiResponse.value = "Meeting Created Successfully!";
          isResponseSuccess.value = true;
          Fluttertoast.showToast(
              msg: "Meeting Created Successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.lightBlueAccent,
              textColor: Colors.white,
              fontSize: 16.0);
          sheduleMeetingScreen();
          resetForm();

          update();
          break;
        case 500:
          apiResponse.value = "Internal Server Error";
          isResponseSuccess.value = false;
          Fluttertoast.showToast(
              msg: "Internal Server Error.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          update();
          break;
        case 503:
          apiResponse.value = "Service Unavailable.";
          isResponseSuccess.value = false;
          Fluttertoast.showToast(
              msg: "Service Unavailable.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          update();
          break;
        case 400:
          apiResponse.value = "Bad Request.";
          isResponseSuccess.value = false;
          Fluttertoast.showToast(
              msg: "Bad Request.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          update();
          break;

        case 408:
          apiResponse.value = "Connection Timeout";
          isResponseSuccess.value = false;
          Fluttertoast.showToast(
              msg: "Connection Timeout",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          update();
          break;
        default:
          apiResponse.value = "Error during communicating the server.";
          isResponseSuccess.value = false;
          Fluttertoast.showToast(
              msg: "Error during communicating the server.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          update();
          break;
      }
      isLoading.value = false;
      update();
    } on OSError catch (err) {
      print(err);
    } on TimeoutException catch (err) {
      Fluttertoast.showToast(
          msg: "Request Timeout.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading.value = false;
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
      isLoading.value = false;
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Something went wrong please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading.value = false;
    }
    // } catch (er) {
    //     isLoading.value = false;
    //     apiResponse.value = ("Internal Server Error, Please try again later.");
    //     isResponseSuccess.value = false;
    //     update();
    //     Fluttertoast.showToast(
    //         msg: "Failed to create Meeting",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.red,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   }
    print("done");
    update();
    isLoading.value = false;
  }

  getRefreshMeetings() {
    final controller = Get.put(ScheduleController());
    controller.futureMeetings = [];
    controller.pastMeetings = [];
    controller.getJsonData();
  }

  sheduleMeetingScreen() {
    Get.toNamed(AppRoutes.scheduleScreen);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    topictxtController.dispose();
    passcodeController.dispose();
  }
}

class Response {
  Response({required this.status, required this.message});
  final String status;
  final String message;

  factory Response.fromJson(Map<String, dynamic> data) {
    final status = data['status'] as String;
    final message = data['message'] as String;
    return Response(status: status, message: message);
  }
}
