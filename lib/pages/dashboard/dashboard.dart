import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/calendar/data/children_item_datasets.dart';
import '../../utils/calendar/data/heatmap_datasets.dart';
import '../../utils/calendar/enums/heatmap_color_mode.dart';
import '../../utils/calendar/enums/heatmap_type.dart';
import '../../utils/calendar/heatmap_calendar.dart';
import '../../utils/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heatLevelController =
      TextEditingController(text: "1");

  bool isOpacityMode = true;
  bool isWidgetMode = true;

  Map<DateTime, HeatmapData> heatMapDatasets = {
    DateTime(2024, 04, 01): HeatmapData(intensity: 1, heatMapChildren: [
      HeatmapChildrenData(
          label: "label1",
          desc: "desc1",
          child: const Icon(
            Icons.fire_extinguisher,
            size: 20,
            color: Colors.amber,
          )),
    ]),
    DateTime(2024, 04, 05): HeatmapData(intensity: 1, heatMapChildren: [
      HeatmapChildrenData(
          label: "label1",
          desc: "desc1",
          child: const Icon(
            Icons.fire_extinguisher,
            size: 20,
            color: Colors.amber,
          )),
      HeatmapChildrenData(
          label: "label2",
          desc: "desc2",
          child: const Icon(
            Icons.water,
            size: 20,
            color: Colors.deepPurple,
          )),
    ]),
    DateTime(2024, 04, 12): HeatmapData(intensity: 1, heatMapChildren: [
      HeatmapChildrenData(
          label: "label1",
          desc: "desc1",
          child: const Icon(
            Icons.fire_extinguisher,
            size: 20,
            color: Colors.amber,
          )),
      HeatmapChildrenData(
          label: "label2",
          desc: "desc2",
          child: const Icon(
            Icons.water,
            size: 20,
            color: Colors.deepPurple,
          )),
      HeatmapChildrenData(
          label: "label3",
          desc: "desc3",
          child: const Icon(
            Icons.flood,
            size: 20,
            color: Colors.blue,
          )),
    ]),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://img.freepik.com/free-photo/gray-abstract-wireframe-technology-background_53876-101941.jpg?w=740&t=st=1717608925~exp=1717609525~hmac=faec03a059d03d94f5eb5cfe849ee24f306ab19cb1b33741e49ce37e5f7b5b7e',
              height: 50.0,
              width: 50.0,
            ),
          )
        ),
        title: Text(AppConstants.stDashboard),
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
            Row(
              children: [
                Flexible(flex: 1, child: Text("data")),
                Flexible(
                    flex: 9,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("Present"),
                            ),
                            Expanded(
                              child: Text("-------"),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
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
            child: HeatMapCalendar(
              flexible: true,
              datasets: heatMapDatasets,
              heatmapType: isWidgetMode
                  ? HeatmapCalendarType.widgets
                  : HeatmapCalendarType.intensity,
              colorMode: isOpacityMode ? ColorMode.opacity : ColorMode.color,
              colorsets: const {
                1: Colors.red,
                3: Colors.orange,
                5: Colors.yellow,
                7: Colors.green,
                9: Colors.blue,
                11: Colors.indigo,
                13: Colors.purple,
              },
              defaultColor: Colors.white,
              onClick: (datetime, heatmapData) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$datetime : $heatmapData')));
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    heatLevelController.dispose();
  }
}
