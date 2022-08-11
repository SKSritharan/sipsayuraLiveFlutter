import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../nav_drawer_draweritem/controller/nav_drawer_controller.dart';
import '../nav_drawer_draweritem/nav_drawer_draweritem.dart';
import '../schedule_screen/controller/schedule_controller.dart';
import 'controller/schedule_meeting_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';

class ScheduleMeetingFormScreen
    extends GetWidget<ScheduleMeetingFormController> {
  int radioGroup = 1;
  int radioGroup1 = 1;
  bool isAutoGen = true;
  bool isPersonalMeetingID = false;
  bool isAutoRec = false;
  bool isModOnlyMsg = false;
  bool isMuteOnStrt = false;
  bool isWebCamOnlyForMod = false;

  ConnectivityResult result = ConnectivityResult.none;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleMeetingFormController());

    return WillPopScope(
      onWillPop: () async {
        return onTapImgVector();
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: new AppBar(
          backgroundColor: Colors.lightBlueAccent,
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
          actions: <Widget>[
            new IconButton(
              onPressed: () {
                settingsScreen();
                // handle the press
              },
              icon: new Icon(Icons.settings),
            ),
          ],
        ),
        drawer: NavDrawerDraweritem(NavDrawerController()),
        body: GetBuilder<ScheduleMeetingFormController>(
          builder: (scheduleMeetingFormController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1.3,
                    decoration: BoxDecoration(
                        color: ColorConstant.whiteA700,
                        boxShadow: [
                          BoxShadow(
                              color: ColorConstant.black90028,
                              spreadRadius: getHorizontalSize(2.00),
                              blurRadius: getHorizontalSize(2.00),
                              offset: Offset(1, 2))
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: getVerticalSize(10.00),
                                  left: MediaQuery.of(context).size.width / 8,
                                  right: MediaQuery.of(context).size.width / 8),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    // onFieldSubmitted: (value) {
                                    //   onTapBtnSave(context);
                                    // },
                                    textInputAction: TextInputAction.next,
                                    focusNode: FocusNode(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: controller.topictxtController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: controller
                                                .topictxtController.text.isEmpty
                                            ? SizedBox()
                                            : Icon(Icons.clear),
                                        onPressed: () => controller
                                            .topictxtController
                                            .clear(),
                                      ),
                                      labelText: "Topic",
                                      // hintText: controller.userName,
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightBlueAccent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightBlueAccent),
                                      ),
                                    ),
                                  ))),
                          const Divider(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 8,
                                top: getVerticalSize(
                                  10.00,
                                ),
                              ),
                              child: Text(
                                "lbl_date_participants".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 8,
                              top: getVerticalSize(
                                4.00,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.chooseDate(),
                                  child: Container(
                                    height: getVerticalSize(
                                      30.00,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        8,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            height: getVerticalSize(
                                              30.00,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                2 /
                                                8,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 0,
                                              margin: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: ColorConstant
                                                      .lightBlue700,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    4.00,
                                                  ),
                                                ),
                                              ),
                                              // child: Text(controller.selectedDate.value.toString(),),
                                              child: Align(
                                                // Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      7.00,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      7.00,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    DateFormat("dd-MM-yyyy")
                                                        .format(controller
                                                            .selectedDate.value)
                                                        .toString(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(
                                //     left: MediaQuery.of(context).size.width / 8,
                                //   ),
                                //   height: getVerticalSize(
                                //     30.00,
                                //   ),
                                //   width:
                                //       MediaQuery.of(context).size.width * 3 / 8,
                                //   child: TextFormField(
                                //     keyboardType: TextInputType.number,
                                //     // onFieldSubmitted: (value) {
                                //     //   onTapBtnSave(context);
                                //     // },
                                //     textInputAction: TextInputAction.next,
                                //     focusNode: FocusNode(),
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return 'Please enter some text';
                                //       } else if (int.parse(value) >
                                //           controller.maxParticipantLimit) {
                                //         return 'Participant count exited try lower.';
                                //       }
                                //       return null;
                                //     },
                                //     controller:
                                //         controller.participantstxtController,
                                //     decoration: InputDecoration(
                                //       suffixIcon: IconButton(
                                //         icon: controller
                                //                 .participantstxtController
                                //                 .text
                                //                 .isEmpty
                                //             ? SizedBox()
                                //             : Icon(Icons.clear),
                                //         onPressed: () => controller
                                //             .participantstxtController
                                //             .clear(),
                                //       ),
                                //       labelText: "Participants",
                                //       labelStyle: TextStyle(
                                //         fontSize: 18,
                                //         color: Colors.black,
                                //       ),
                                //       enabledBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: Colors.lightBlueAccent),
                                //       ),
                                //       focusedBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: Colors.lightBlueAccent),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: getHorizontalSize(
                                          60.00,
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          // onFieldSubmitted: (value) {
                                          //   onTapBtnSave(context);
                                          // },
                                          textInputAction: TextInputAction.next,
                                          focusNode: FocusNode(),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            } else if (int.parse(value) >
                                                controller
                                                    .maxParticipantLimit) {
                                              return 'Participant count exited try lower.';
                                            }
                                            return null;
                                          },
                                          controller: controller
                                              .participantstxtController,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: controller
                                                      .participantstxtController
                                                      .text
                                                      .isEmpty
                                                  ? SizedBox()
                                                  : Icon(Icons.clear),
                                              onPressed: () => controller
                                                  .participantstxtController
                                                  .clear(),
                                            ),
                                            labelText: "Participants",
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                  // child: Text(
                                  //   "msg_personal_meetin".tr,
                                  //   textAlign: TextAlign.left,
                                  //   style: AppStyle
                                  //       .textstylemontserratromanregular92
                                  //       .copyWith(
                                  //     fontSize: getFontSize(
                                  //       9,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 8,
                                top: getVerticalSize(
                                  10.00,
                                ),
                              ),
                              child: Text(
                                "lbl_start".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getVerticalSize(2.00),
                                bottom: getVerticalSize(15.00)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                              ),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                                getVerticalSize(
                                                                    5.00)),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              2.5 /
                                                              8,
                                                          child: Container(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .chooseStartTime(),
                                                              child: Container(
                                                                height:
                                                                    getVerticalSize(
                                                                  30.00,
                                                                ),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    2 /
                                                                    8,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                    6.00,
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            getVerticalSize(
                                                                          30.00,
                                                                        ),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            2 /
                                                                            8,
                                                                        child:
                                                                            Card(
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          elevation:
                                                                              0,
                                                                          margin:
                                                                              EdgeInsets.all(0),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            side:
                                                                                BorderSide(
                                                                              color: ColorConstant.lightBlue700,
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              getHorizontalSize(
                                                                                4.00,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            // Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(
                                                                                top: getVerticalSize(
                                                                                  7.00,
                                                                                ),
                                                                                bottom: getVerticalSize(
                                                                                  7.00,
                                                                                ),
                                                                              ),
                                                                              child: Obx(
                                                                                () => Text(
                                                                                  DateFormat('HH:mm').format(DateTime(controller.selectedDate.value.year, controller.selectedDate.value.month, controller.selectedDate.value.day, controller.selectedStartTime.value.hour, controller.selectedStartTime.value.minute)).toString(),
                                                                                ),
                                                                              ),
                                                                              // child: Text(
                                                                              //   "${controller.selectedStartTime.value.hour}:${controller.selectedStartTime.value.minute}",
                                                                              // ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                  ])),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(15.00),
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                                getVerticalSize(
                                                                    5.00),
                                                            right:
                                                                getHorizontalSize(
                                                                    1.00)),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              2.5 /
                                                              8,
                                                          child: Container(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .chooseEndTime(),
                                                              child: Container(
                                                                height:
                                                                    getVerticalSize(
                                                                  30.00,
                                                                ),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    2 /
                                                                    8,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                    6.00,
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            getVerticalSize(
                                                                          30.00,
                                                                        ),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            2 /
                                                                            8,
                                                                        child:
                                                                            Card(
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          elevation:
                                                                              0,
                                                                          margin:
                                                                              EdgeInsets.all(0),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            side:
                                                                                BorderSide(
                                                                              color: ColorConstant.lightBlue700,
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              getHorizontalSize(
                                                                                4.00,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            // Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(
                                                                                top: getVerticalSize(
                                                                                  7.00,
                                                                                ),
                                                                                bottom: getVerticalSize(
                                                                                  7.00,
                                                                                ),
                                                                              ),
                                                                              child: Obx(
                                                                                () => Text(
                                                                                  DateFormat('HH:mm').format(DateTime(controller.selectedDate.value.year, controller.selectedDate.value.month, controller.selectedDate.value.day, controller.selectedEndTime.value.hour, controller.selectedEndTime.value.minute)).toString(),
                                                                                ),
                                                                              ),
                                                                              // child: Text(
                                                                              //   "${controller.selectedEndTime.value.hour}:${controller.selectedEndTime.value.minute}",
                                                                              // ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                  ]))
                                        ])),
                                const Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 8,
                                      top: getVerticalSize(
                                        7.00,
                                      ),
                                    ),
                                    child: Text(
                                      "msg_meeting_id_pa".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 8,
                                      top: getVerticalSize(
                                        4.00,
                                      ),
                                      right: getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                    width: getHorizontalSize(
                                      129.00,
                                    ),
                                    child: InkWell(
                                      onTap: () =>
                                          controller.isAutoGenerated(isAutoGen),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: ColorConstant.black900,
                                                width: getHorizontalSize(
                                                  1.00,
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(
                                                  2.00,
                                                ),
                                              ),
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value: controller.isMeetingIDState,
                                            onChanged: (value) {
                                              controller.isAutoGenerated(value);
                                              controller.update();
                                            },
                                          ),
                                          Expanded(
                                            child: Text(
                                              "msg_generate_automa".tr,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 8,
                                      top: getVerticalSize(
                                        6.00,
                                      ),
                                      right: getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                    width: getHorizontalSize(
                                      180.00,
                                    ),
                                    child: InkWell(
                                      onTap: () => controller
                                          .isAutoGenerated(isPersonalMeetingID),
                                      child: Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment
                                        //     .spaceEvenly,
                                        children: [
                                          Checkbox(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: ColorConstant.black900,
                                                width: getHorizontalSize(
                                                  1.00,
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(
                                                  2.00,
                                                ),
                                              ),
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value: true,
                                            onChanged: null,
                                            // value: controller
                                            //     .isPersonalMeetingIDState,
                                            // onChanged: (value) {
                                            //   controller
                                            //       .isPersonalMeetingID(
                                            //       value);
                                            //   controller.update();
                                            // },
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: getHorizontalSize(
                                                    60.00,
                                                  ),
                                                  child: TextFormField(
                                                    onFieldSubmitted: (value) {
                                                      onTapBtnSave(context);
                                                    },
                                                    focusNode: FocusNode(),
                                                    controller: controller
                                                        .passcodeController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "lbl_passcode2".tr,
                                                      labelStyle: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .lightBlueAccent),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .lightBlueAccent),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // child: Text(
                                            //   "msg_personal_meetin".tr,
                                            //   textAlign: TextAlign.left,
                                            //   style: AppStyle
                                            //       .textstylemontserratromanregular92
                                            //       .copyWith(
                                            //     fontSize: getFontSize(
                                            //       9,
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        6 /
                                        8,
                                    padding: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 8,
                                      top: getVerticalSize(
                                        5.00,
                                      ),
                                    ),
                                    child: Text(
                                      "msg_only_users_who".tr,
                                      maxLines: null,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 8,
                                      top: getVerticalSize(7.00),
                                      right: MediaQuery.of(context).size.width /
                                          8),
                                  child: ExpansionTile(
                                    title: Text(
                                      "lbl_advanced".tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: getVerticalSize(7.00),
                                          ),
                                          width: getHorizontalSize(121.00),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    scheduleMeetingFormController
                                                        .isAutoRecording(
                                                            isAutoRec),
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: ColorConstant
                                                          .black900,
                                                      width: getHorizontalSize(
                                                          1.00),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(2.00),
                                                    ),
                                                  ),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: controller
                                                      .isAutoRecordingState,
                                                  onChanged: (value) {
                                                    controller
                                                        .isAutoRecording(value);
                                                    controller.update();
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "msg_auto_start_reco".tr,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: getVerticalSize(7.00),
                                              right: getHorizontalSize(12.00)),
                                          width: getHorizontalSize(121.00),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    scheduleMeetingFormController
                                                        .isAutoRecording(
                                                            isModOnlyMsg),
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: ColorConstant
                                                            .black900,
                                                        width:
                                                            getHorizontalSize(
                                                                1.00)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(2.00),
                                                    ),
                                                  ),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: controller
                                                      .isModeratorOnlyMessageState,
                                                  onChanged: (value) {
                                                    controller
                                                        .isModeratorOnlyMessage(
                                                            value);
                                                    controller.update();
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "msg_moderator_messa".tr,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: getVerticalSize(7.00),
                                              right: getHorizontalSize(12.00)),
                                          width: getHorizontalSize(121.00),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    scheduleMeetingFormController
                                                        .isMuteOnStart(
                                                            isMuteOnStrt),
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: ColorConstant
                                                          .black900,
                                                      width: getHorizontalSize(
                                                          1.00),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(2.00),
                                                    ),
                                                  ),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: controller
                                                      .isMuteOnStartState,
                                                  onChanged: (value) {
                                                    controller
                                                        .isMuteOnStart(value);
                                                    controller.update();
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "lbl_mute_on_start".tr,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: getVerticalSize(7.00),
                                              right: getHorizontalSize(12.00)),
                                          width: getHorizontalSize(121.00),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    scheduleMeetingFormController
                                                        .isMuteOnStart(
                                                            isWebCamOnlyForMod),
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: ColorConstant
                                                              .black900,
                                                          width:
                                                              getHorizontalSize(
                                                                  1.00)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  2.00))),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: controller
                                                      .isWebCamOnlyForModeratorState,
                                                  onChanged: (value) {
                                                    controller
                                                        .isWebCamOnlyForModerator(
                                                            value);
                                                    controller.update();
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      "msg_web_cam_only_fo".tr,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: getVerticalSize(10.00)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Obx(() => Container(
                                              alignment: Alignment.center,
                                              height: getVerticalSize(
                                                40,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  3 /
                                                  8,
                                              child: ElevatedButton(
                                                onPressed: controller
                                                        .isLoading.value
                                                    ? null
                                                    : () {
                                                        onTapBtnCancel(context);
                                                      },
                                                child: Text(
                                                  "lbl_cancel".tr,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.white),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                            Color>(Colors.red),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20.0),
                                                            side: const BorderSide(
                                                                color: Colors.red)))),
                                              ),
                                            )),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //     left: MediaQuery.of(context)
                                        //             .size
                                        //             .width *
                                        //         0.5 /
                                        //         8,
                                        //     right: MediaQuery.of(context)
                                        //             .size
                                        //             .width /
                                        //         8,
                                        //   ),
                                        //   child: GestureDetector(
                                        //     onTap: () {
                                        //       onTapBtnCancel(context);
                                        //     },
                                        //     child: Container(
                                        //       alignment: Alignment.center,
                                        //       height: getVerticalSize(
                                        //         23.08,
                                        //       ),
                                        //       width: MediaQuery.of(context)
                                        //               .size
                                        //               .width *
                                        //           3 /
                                        //           8,
                                        //       decoration: AppDecoration
                                        //           .textstylenunitosemibold91,
                                        //       child: Text(
                                        //         "lbl_cancel".tr,
                                        //         textAlign: TextAlign.center,
                                        //         style: AppStyle
                                        //             .textstylenunitosemibold91
                                        //             .copyWith(
                                        //           fontSize: getFontSize(
                                        //             9,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Obx(() => Container(
                                              alignment: Alignment.center,
                                              height: getVerticalSize(
                                                40,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  3 /
                                                  8,
                                              child: ElevatedButton(
                                                onPressed: controller
                                                        .isLoading.value
                                                    ? null
                                                    : () {
                                                        onTapBtnSave(context);
                                                      },
                                                child: controller
                                                        .isLoading.value
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          SizedBox(
                                                            height: 10.0,
                                                            width: 10.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text("Please wait",
                                                              style: TextStyle(
                                                                  fontSize: 18))
                                                        ],
                                                      )
                                                    : Text(
                                                        "lbl_save".tr,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.white),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            Colors
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          elevation: 2.0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_filled_rounded),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_sharp),
              label: 'Create',
            ),
          ],
          onTap: navRoute,
        ),
      )),
    );
  }

  navRoute(int tabIndex) {
    switch (tabIndex) {
      case 0:
        onTapImgMdischedule();
        break;
      case 1:
        onTapImgVector();
        break;
      case 2:
        onTapImgVector1();
        break;
    }
  }

  onTapImgVector() {
    Get.toNamed(AppRoutes.dashboardScreen);
  }

  onTapImgVector1() {
    Get.toNamed(AppRoutes.scheduleMeetingForm);
  }

  onTapImgMdischedule() {
    Get.toNamed(AppRoutes.scheduleScreen);
  }

  settingsScreen() {
    Get.toNamed(AppRoutes.settingsScreen);
  }

  onTapBtnCancel(BuildContext context) {
    Navigator.pop(context); // Get.back();
  }

  onTapBtnSave(context) async {
    result = await Connectivity().checkConnectivity();
    if (_formKey.currentState!.validate()) {
      if (DateTime(
              controller.selectedDate.value.year,
              controller.selectedDate.value.month,
              controller.selectedDate.value.day,
              controller.selectedStartTime.value.hour,
              controller.selectedStartTime.value.minute)
          .isAfter(DateTime(
              controller.selectedDate.value.year,
              controller.selectedDate.value.month,
              controller.selectedDate.value.day,
              controller.selectedEndTime.value.hour,
              controller.selectedEndTime.value.minute))) {
        Fluttertoast.showToast(
            msg: "Invalid End Time.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (DateTime(
              controller.selectedDate.value.year,
              controller.selectedDate.value.month,
              controller.selectedDate.value.day,
              controller.selectedStartTime.value.hour,
              controller.selectedStartTime.value.minute)
          .isAtSameMomentAs(DateTime(
              controller.selectedDate.value.year,
              controller.selectedDate.value.month,
              controller.selectedDate.value.day,
              controller.selectedEndTime.value.hour,
              controller.selectedEndTime.value.minute))) {
        Fluttertoast.showToast(
            msg: "End Time cannot be same as Start Time.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (DateTime(
              controller.selectedDate.value.year,
              controller.selectedDate.value.month,
              controller.selectedDate.value.day,
              controller.selectedStartTime.value.hour,
              controller.selectedStartTime.value.minute)
          .isBefore(new DateTime.now())) {
        Fluttertoast.showToast(
            msg: "Can't create a meeting in past.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
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
          controller.apiConnect();
        }
      }
    }
  }
}
