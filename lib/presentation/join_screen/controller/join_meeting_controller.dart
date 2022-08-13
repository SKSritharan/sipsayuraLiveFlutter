import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../profile_screen/controller/profile_controller.dart';
import '../../schedule_screen/controller/schedule_controller.dart';
import '/core/app_export.dart';
import 'package:bbb_app/presentation/join_screen/models/join_meeting_model.dart';

class JoinMeetingController extends GetxController {
  Rx<JoinMeetingModel> joinMeetingModelObj = JoinMeetingModel().obs;

  // var sharingText;
  //  String meetingLink ='http://localhost:4000/join/u';
  //
  // userName() {
  //   final controller = Get.put(ProfileController());
  //   var userName= controller.profileModel.value.firstName;
  //
  //   return userName;
  // }

  getMeetingId() {
    final controller = Get.put(ScheduleController());
    var meeting_id;
    if (controller.isUpcomingMeetingListClicked) {
      meeting_id =
          controller.futureMeetings[controller.clickedIndex]["meeting_id"];
    } else {
      meeting_id =
          controller.pastMeetings[controller.clickedIndex]["meeting_id"];
    }

    return meeting_id;
  }

  var data = [];
  var apiResponse;

  var joinMeetingResponse;
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getJsonData();
  }

  // sharingText =${userName()} +"is inviting you to a scheduled LetMO meeting.\nTopic: Sritharan's LetMO Meeting\nTime: Jul 22, 2022 12:00 PM Colombo\nJoin LetMO Meeting\n${meetingLink}\nMeeting ID: ${meetingID}\nPasscode: ${meetingPasscode}";

  void getJsonData() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String token = prefs.getString("Token")!;
    try {
      Uri url =
          Uri.parse("http://192.168.8.175:4000/join/info/${getMeetingId()}");
      final response = await http.post(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, HEAD",
        "Access-Control-Allow-Credentials": "true",
        "authorization": "Bearer ${token}",
      }, body: {});
      print(response.body);
      // var convertDataToJson = jsonDecode(response.body);
      apiResponse = jsonDecode(response.body);
      // data = convertDataToJson;
      // print(response.body);
      isLoading.value = false;
      update();
    } catch (er) {
      print(er.toString());
      isLoading.value = false;
      update();
    }
    print("done");
    // isLoading.value= false;
    update();
  }

  void joinMeeting() async {
    isLoading1.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String token = prefs.getString("Token")!;
    try {
      Uri url = Uri.parse("http://192.168.8.175:4000/join/${getMeetingId()}");
      final response = await http.post(url, headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, HEAD",
        "Access-Control-Allow-Credentials": "true",
        "authorization": "Bearer ${token}",
      }, body: {});
      print(response.body);
      // var convertDataToJson = jsonDecode(response.body);
      joinMeetingResponse = jsonDecode(response.body);
      // data = convertDataToJson;
      // print(response.body);
      isLoading1.value = false;
      update();
    } catch (er) {
      print(er.toString());
      isLoading1.value = false;
      update();
    }
    print("done");
    //isLoading1.value= false;
    update();
  }

  void deleteMeeting() async {
    isLoading2.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String token = prefs.getString("Token")!;
    try {
      Uri url = Uri.parse(
          "http://192.168.8.175:4000/meetings/deleteMeeting/${getMeetingId()}");
      final response = await http.delete(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, HEAD",
          "Access-Control-Allow-Credentials": "true",
          "authorization": "Bearer ${token}",
        },
      );
      print(response.body);
      // var convertDataToJson = jsonDecode(response.body);
      joinMeetingResponse = jsonDecode(response.body);
      // data = convertDataToJson;
      // print(response.body);
      isLoading2.value = false;
      update();
    } catch (er) {
      print(er.toString());
      isLoading2.value = false;
      update();
    }
    print("done");
    isLoading2.value = false;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
