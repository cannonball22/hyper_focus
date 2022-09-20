import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hyper_focus/screens/participantsScreen.dart';
import 'overviewScreen.dart';

class LiveStat extends StatefulWidget {
  const LiveStat({
    Key? key,
    required this.courseName,
    required this.courseID,
    required this.sessionID,
  }) : super(key: key);
  final String courseName;
  final String courseID;
  final String? sessionID;
  @override
  _LiveStatState createState() => _LiveStatState();
}

class _LiveStatState extends State<LiveStat> {
  QuerySnapshot? participantsData;

  Future getParticipantsData() async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .collection("participants")
        .get()
        .then((result) {
      participantsData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.onBackground,
            indicatorColor: Theme.of(context).colorScheme.onBackground,
            tabs: [
              Tab(
                text: "Overview",
              ),
              Tab(text: "Participants"),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "Live Statistics",
            style: TextStyle(
              fontFamily: "SF UI Display",
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 32,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            OverviewScreen(
                sessionID: widget.sessionID, courseID: widget.courseID),
            ParticipantsScreen(
                sessionID: widget.sessionID, courseID: widget.courseID),
          ],
        ),
      ),
    );
  }
}
/*
class LiveData {
  LiveData(this.interval, this.data);
  final int interval;
  final double data;
}
*/
/*
/// Specifies the list of chart sample data.
List<ChartSampleData> chartData = <ChartSampleData>[
  ChartSampleData(x: 1, y: 30),
  ChartSampleData(x: 3, y: 13),
  ChartSampleData(x: 5, y: 80),
  ChartSampleData(x: 7, y: 30),
  ChartSampleData(x: 9, y: 72)
];
*/

/// Get the random value.
num _getRandomInt(int min, int max) {
  return min + random.nextInt(max - min);
}

/*
/// Method to update the chart data.
List<ChartSampleData> _getChartData() {
  chartData.add(ChartSampleData(x: 1, y: _getRandomInt(10, 100)));
  chartData.add(ChartSampleData(x: 3, y: _getRandomInt(10, 100)));
  chartData.add(ChartSampleData(x: 5, y: _getRandomInt(10, 100)));
  chartData.add(ChartSampleData(x: 7, y: _getRandomInt(10, 100)));
  chartData.add(ChartSampleData(x: 9, y: _getRandomInt(10, 100)));
  return chartData;
}
*/
/// Creates an instance of random to generate the random number.
final Random random = Random();
int count = 0;
/*
/// Continuously updating the data source based on timer.
void _updateDataSource(Timer timer) {
  chartData.add(_ChartData(count, _getRandomInt(10, 100)));
  if (chartData.length == 20) {
    chartData.removeAt(0);
    _chartSeriesController?.updateDataSource(
      addedDataIndexes: <int>[chartData.length - 1],
      removedDataIndexes: <int>[0],
    );
  } else {
    _chartSeriesController?.updateDataSource(
      addedDataIndexes: <int>[chartData.length - 1],
    );
  }
  count = count + 1;
}

Timer? timer;

@override
void initState() {
  //super.initState();
  timer = Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
}*/
/*

        SfSparkLineChart(
          //Enable the trackball

          trackball: const SparkChartTrackball(
            activationMode: SparkChartActivationMode.tap,
          ),
          //Enable marker
          marker: const SparkChartMarker(
            displayMode: SparkChartMarkerDisplayMode.all,
          ),
          width: 8,
          color: const Color(0xff30DB5B),
          axisCrossesAt: 0,

          axisLineColor: const Color(0xff9797AA),
          axisLineWidth: 0.5,
          data: dataList,

          /*
          series: <LineSeries<LiveData, int>>[
            LineSeries<LiveData, int>(
              // Bind data source
              dataSource: <LiveData>[
                LiveData(1, 35),
                LiveData(2, 28),
                LiveData(3, 34),
                LiveData(4, 32),
                LiveData(5, 40)
              ],
              xValueMapper: (LiveData data, _) => data.interval,
              yValueMapper: (LiveData data, _) => data.data,
            )*/
        ),

 */
