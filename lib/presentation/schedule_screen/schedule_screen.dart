import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';

import '../nav_drawer_draweritem/controller/nav_drawer_controller.dart';
import '../nav_drawer_draweritem/nav_drawer_draweritem.dart';
import '../schedule_meeting_form_screen/controller/schedule_meeting_form_controller.dart';
import '../schedule_screen/widgets/schedule_item_widget.dart';
import 'controller/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:bbb_app/core/app_export.dart';

class ScheduleScreen extends GetWidget<ScheduleController> {
  ConnectivityResult result = ConnectivityResult.none;

  TabBar get _tabBar => TabBar(
        tabs: [
          Tab(
              child: Text(
            'Upcoming',
            style: TextStyle(color: Colors.black),
          )),
          Tab(
              child: Text(
            'Past',
            style: TextStyle(color: Colors.black),
          )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return onTapImgVector();
        },
        child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: GetBuilder<ScheduleController>(
              builder: (ScheduleController) => Scaffold(
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
                      },
                      icon: new Icon(Icons.settings),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: ColoredBox(
                      color: Colors.white,
                      child: _tabBar,
                    ),
                  ),
                ),
                drawer: NavDrawerDraweritem(NavDrawerController()),
                body: TabBarView(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Container(
                              width: size.width,
                              child: controller.isInternetOn.value
                                  ? Obx(() => Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.whiteA700,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      ColorConstant.black90028,
                                                  spreadRadius:
                                                      getHorizontalSize(2.00),
                                                  blurRadius:
                                                      getHorizontalSize(2.00),
                                                  offset: Offset(1, 2))
                                            ]),
                                        child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(14.00),
                                                  top: getVerticalSize(0.00),
                                                  right:
                                                      getHorizontalSize(14.00),
                                                ),
                                                child: RefreshIndicator(
                                                  onRefresh: () async {
                                                    refreshListview(context);
                                                  },
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      // crossAxisAlignment:
                                                      // CrossAxisAlignment.end,
                                                      // mainAxisAlignment:
                                                      // MainAxisAlignment.start,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left:
                                                                    getHorizontalSize(
                                                                        6),
                                                                top:
                                                                    getVerticalSize(
                                                                        18.00),
                                                              ),
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          border:
                                                                              Border(
                                                                                  bottom:
                                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2.0,
                                                                  ))),
                                                                  child: Text(
                                                                      "Upcoming Schedule"
                                                                          .tr,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .textstylemontserratregular11
                                                                          .copyWith(
                                                                              fontSize: getFontSize(15)))),
                                                            )),
                                                        controller
                                                                .isLoading.value
                                                            ? Container(
                                                                height: 400.0,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Center(
                                                                    child: SizedBox(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            CircularProgressIndicator())),
                                                              )
                                                            : Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: getHorizontalSize(
                                                                          6.00),
                                                                      top: getVerticalSize(
                                                                          17.50),
                                                                      right: getHorizontalSize(
                                                                          0.61)),
                                                                  child: controller
                                                                              .futureMeetings
                                                                              .length ==
                                                                          0
                                                                      ? Container(
                                                                          height:
                                                                              400,
                                                                          alignment: Alignment
                                                                              .center,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text("No meetings to show"),
                                                                              TextButton(onPressed: () => refreshListview(context), child: Text(controller.isLoading.value ? "Please wait Refreshing List" : "Refresh"))
                                                                            ],
                                                                          ))
                                                                      : ListView
                                                                          .builder(
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          // scrollDirection: Axis.horizontal,
                                                                          // physics:
                                                                          //     BouncingScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: controller
                                                                              .futureMeetings
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            // controller
                                                                            //     .data[index]["meetingName"].toString();
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                controller.isUpcomingListClicked(index);
                                                                                onTapBtnjoin(context);
                                                                              },
                                                                              child: ScheduleItemWidget(
                                                                                duration: controller.futureMeetings[index]["max_duration"].toString(),
                                                                                date: controller.futureMeetings[index]["scheduled_at_Date"].toString(),
                                                                                time: controller.futureMeetings[index]["scheduled_at_Time"].toString(),
                                                                                meetingID: controller.futureMeetings[index]["meeting_id"].toString(),
                                                                                meetingName: controller.futureMeetings[index]["name"].toString().replaceAll('%20', ' ').replaceAll('%27', '\''),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  : Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            "No Internet",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          IconButton(
                                              onPressed: () =>
                                                  refreshListview(context),
                                              icon: Icon(Icons.refresh))
                                        ],
                                      ),
                                    )),
                        ),
                      ],
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Container(
                            width: size.width,
                            child: controller.isInternetOn.value
                                ? Obx(() => Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                          color: ColorConstant.whiteA700,
                                          boxShadow: [
                                            BoxShadow(
                                                color: ColorConstant.black90028,
                                                spreadRadius:
                                                    getHorizontalSize(2.00),
                                                blurRadius:
                                                    getHorizontalSize(2.00),
                                                offset: Offset(1, 2))
                                          ]),
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(14.00),
                                                  top: getVerticalSize(0.00),
                                                  right:
                                                      getHorizontalSize(14.00)),
                                              child: RefreshIndicator(
                                                onRefresh: () async {
                                                  refreshListview(context);
                                                },
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    // crossAxisAlignment:
                                                    // CrossAxisAlignment.end,
                                                    // mainAxisAlignment:
                                                    // MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                      6),
                                                              top:
                                                                  getVerticalSize(
                                                                      18.00),
                                                            ),
                                                            child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            Border(
                                                                                bottom:
                                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2.0,
                                                                ))),
                                                                child: Text(
                                                                    "Past Schedule"
                                                                        .tr,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .textstylemontserratregular11
                                                                        .copyWith(
                                                                            fontSize:
                                                                                getFontSize(15)))),
                                                          )),
                                                      controller.isLoading.value
                                                          ? Container(
                                                              height: 400.0,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Center(
                                                                  child: SizedBox(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      child:
                                                                          CircularProgressIndicator())),
                                                            )
                                                          : Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: getHorizontalSize(
                                                                        6.00),
                                                                    top: getVerticalSize(
                                                                        17.50),
                                                                    right: getHorizontalSize(
                                                                        0.61)),
                                                                child: controller
                                                                            .pastMeetings
                                                                            .length ==
                                                                        0
                                                                    ? Container(
                                                                        height:
                                                                            400,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text("No meetings to show"),
                                                                            TextButton(
                                                                                onPressed: () => refreshListview(context),
                                                                                child: Text(controller.isLoading.value ? "Please wait Refreshing List" : "Refresh"))
                                                                          ],
                                                                        ))
                                                                    : ListView
                                                                        .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        // physics:
                                                                        //     BouncingScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: controller
                                                                            .pastMeetings
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              controller.isPastListClicked(index);
                                                                              onTapBtnjoin(context);
                                                                            },
                                                                            child:
                                                                                ScheduleItemWidget(
                                                                              duration: controller.pastMeetings[index]["max_duration"].toString(),
                                                                              date: controller.pastMeetings[index]["scheduled_at_Date"].toString(),
                                                                              time: controller.pastMeetings[index]["scheduled_at_Time"].toString(),
                                                                              meetingID: controller.pastMeetings[index]["meeting_id"].toString(),
                                                                              meetingName: controller.pastMeetings[index]["name"].toString().replaceAll('%20', ' ').replaceAll('%27', '\''),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                : Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "No Internet",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        IconButton(
                                            onPressed: () =>
                                                refreshListview(context),
                                            icon: Icon(Icons.refresh))
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: 0,
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
              ),
            ),
          ),
        ));
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

  refreshListview(context) async {
    result = await Connectivity().checkConnectivity();
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
      controller.futureMeetings = [];
      controller.pastMeetings = [];
      controller.getJsonData();
    }
  }

  onTapImgVector() {
    Get.toNamed(AppRoutes.dashboardScreen);
  }

  onTapImgVector1() {
    loadDataForMeetings();
    Get.toNamed(AppRoutes.scheduleMeetingForm);
  }

  onTapImgMdischedule() {
    Get.toNamed(AppRoutes.scheduleScreen);
  }

  settingsScreen() {
    Get.toNamed(AppRoutes.settingsScreen);
  }

  onTapBtnjoin(context) async {
    // Get.toNamed(AppRoutes.joinScreen);
    result = await Connectivity().checkConnectivity();
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
      Get.toNamed(AppRoutes.joinMeetingScreen);
    }
  }

  loadDataForMeetings() {
    final controller = Get.put(ScheduleMeetingFormController());
    controller.putUserMeeting();
  }
}
