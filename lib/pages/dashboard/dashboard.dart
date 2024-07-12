import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/dashboard/dashboardcontroller.dart';
import '../../models/dashboard/all_attendance_history_model.dart';
import '../../services/ApiRequest.dart';
import '../../utils/calendar/data/children_item_datasets.dart';
import '../../utils/calendar/data/heatmap_datasets.dart';
import '../../utils/calendar/enums/heatmap_color_mode.dart';
import '../../utils/calendar/enums/heatmap_type.dart';
import '../../utils/calendar/heatmap_calendar.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class DashboardPage extends StatefulWidget {
  final String stUserImagePath;
  final String stUserName;
  final String stLoginToken;
  final int stUserId;

  const DashboardPage({Key? key,
    required this.stUserImagePath,
    required this.stUserName,
    required this.stLoginToken,
    required this.stUserId})
      : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  final DashboardController _DashboardController =
  Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    String stYear = DateFormat('yyyy').format(DateTime.now());
    String stMonth = DateFormat('MM').format(DateTime.now());
    print("stYear $stYear and stMonth $stMonth");
    final allAttendanceHistoryParams = <String, dynamic>{};
    allAttendanceHistoryParams['user_id'] = widget.stUserId;
    allAttendanceHistoryParams['year'] = int.parse(stYear);
    allAttendanceHistoryParams['month'] = int.parse(stMonth);
    _DashboardController.callGetAllAttendanceHistoryAPI(
        context, allAttendanceHistoryParams, widget.stLoginToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(),
              child: FittedBox(
                child: Image.network(widget.stUserImagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        title: Text(widget.stUserName),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10),
          Icon(Icons.menu),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendarWithValue(),
            SizedBox(height: 10),
            Text("Paid"),
            SizedBox(height: 10),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _DashboardController.leaveList.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_DashboardController.leaveList[position]),
                      Container(
                        height: 25,
                        width: 25,
                        color: Colors.green,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("1",
                              style:
                              TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Text("Unpaid"),
            SizedBox(height: 10),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _DashboardController.unpaidLeaveList.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_DashboardController.unpaidLeaveList[position]),
                      Container(
                        height: 25,
                        width: 25,
                        color: Colors.green,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("1",
                              style:
                              TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarWithValue() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Obx(() =>
                Visibility(
                  visible: _DashboardController.isShowCalendar.value == true,
                  child: HeatMapCalendar(
                    flexible: true,
                    datasets: _DashboardController.heatMapDatasets,
                    heatmapType: HeatmapCalendarType.intensity,
                    colorMode: ColorMode.color,
                    textColor: Colors.white,
                    onMonthChange: (datetime) {},
                    colorsets: const {
                      1: Colors.red,
                      3: Colors.orange,
                      5: Colors.yellow,
                      7: Colors.green,
                      9: Colors.blue,
                      11: Colors.indigo,
                      13: Colors.purple,
                    },
                    defaultColor: Colors.green,
                    onClick: (datetime, heatmapData) {
                      /*ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$datetime : $heatmapData')));*/
                    },
                  ),
                )),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    //dateController.dispose();
    _DashboardController.heatLevelController.dispose();
  }
}
