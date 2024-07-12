import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/dashboard/all_attendance_history_model.dart';
import '../../services/ApiRequest.dart';
import '../../utils/calendar/data/children_item_datasets.dart';
import '../../utils/calendar/data/heatmap_datasets.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class DashboardController extends GetxController {
  var totalPresent = 15.5;
  var totalSick = 1.5;
  var totalCasual = 1;
  int totalEarned = 1;
  int totalLoyalty = 1;
  int totalSatOff = 1;
  int totalCompOff = 1;
  int totalHoliday = 1;
  int totalWeekOff = 4;
  int totalAbsent = 1;
  int totalLossOfPay = 1;
  int totalNoData = 2;
  int totalNotApplicable = 2;

  List<String> leaveList = [
    "Present",
    "Sick",
    "Casual",
    "Earned",
    "Loyalty",
    "Sat Off",
    "Comp Off",
    "Holiday",
    "Week Off",
    "Absent",
    "Loss of Pay",
    "No Data",
    "Not Applicable"
  ];

  List<String> unpaidLeaveList = [
    "Absent",
    "Loss of Pay",
    "No Data",
    "Not Applicable"
  ];

  List<Map<DateTime, HeatmapData>>? calendarDatasets;
  final TextEditingController heatLevelController =
      TextEditingController(text: "1");
  bool isOpacityMode = false;
  bool isWidgetMode = false;
  RxBool isShowCalendar = false.obs;
  Map<DateTime, HeatmapData>? heatMapDatasets;
  AllAttendanceHistoryModel? allAttendanceHistoryModel;

  callGetAllAttendanceHistoryAPI(
      BuildContext context, var params, String stLoginToken) {
    ApiRequest(
            path: AppConstants.stGetAllAttendanceHistoryEndpoint,
            data: params,
            methoud: AppConstants.POST_METHOUD,
            context: context,
            stToken: stLoginToken)
        .request(onSuccess: (data, response) {
      allAttendanceHistoryModel = AllAttendanceHistoryModel.fromJson(response);
      if (allAttendanceHistoryModel!.status == 200) {
        //now calculate all leaves
        calculateAllLeaves();
      } else {
        AppHelpers.showLongToast(allAttendanceHistoryModel!.message!);
      }
    }, onError: (error) {
      AppHelpers.showLongToast(AppConstants.stNetworkError);
      print("callGetAllAttendanceHistoryAPI error $error");
    });
  }

  calculateAllLeaves() {
    if (allAttendanceHistoryModel!.data!.isNotEmpty) {
      isShowCalendar.value = true;
      String stMonth = DateFormat('MM').format(DateTime.now());
      int intMonth = int.parse(stMonth);
      heatMapDatasets = {
        DateTime(2024, intMonth, 1):
            HeatmapData(intensity: 5, heatMapChildren: [
          HeatmapChildrenData(
              label: "label1",
              desc: "desc1",
              child: const Icon(
                Icons.fire_extinguisher,
                size: 20,
              )),
        ]),
        DateTime(2024, intMonth, 10):
            HeatmapData(intensity: 5, heatMapChildren: [
          HeatmapChildrenData(
              label: "label2",
              desc: "desc2",
              child: const Icon(
                Icons.fire_extinguisher,
                size: 20,
              )),
        ]),
        DateTime(2024, intMonth, 14):
            HeatmapData(intensity: 5, heatMapChildren: [
          HeatmapChildrenData(
              label: "label3",
              desc: "desc3",
              child: const Icon(
                Icons.fire_extinguisher,
                size: 20,
              )),
        ]),
        DateTime(2024, intMonth, 25):
            HeatmapData(intensity: 5, heatMapChildren: [
          HeatmapChildrenData(
              label: "label4",
              desc: "desc4",
              child: const Icon(
                Icons.fire_extinguisher,
                size: 20,
              )),
        ]),
        DateTime(2024, intMonth, 28):
            HeatmapData(intensity: 5, heatMapChildren: [
          HeatmapChildrenData(
              label: "label5",
              desc: "desc5",
              child: const Icon(
                Icons.fire_extinguisher,
                size: 20,
              )),
        ]),
      };
    }
  }
}
