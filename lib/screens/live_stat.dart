import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hyper_focus/widgets/blurry_title.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'create_quiz_screen.dart';

class LiveStat extends StatefulWidget {
  const LiveStat(
      {Key? key,
      required this.courseName,
      required this.courseID,
      required this.sessionId})
      : super(key: key);
  final String courseName;
  final String courseID;
  final String? sessionId;
  @override
  _LiveStatState createState() => _LiveStatState();
}

class _LiveStatState extends State<LiveStat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BlurryTitle(
        title: "Live Statistics",
      ),
      backgroundColor: const Color(0xff1C1C1E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Live Overview",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "AvantGarde Bk BT",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Class key performance indicators",
                        style: TextStyle(
                          fontFamily: "SF Pro Text",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff1C1C1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildStat("Attendance", 75),
                            buildStat("Hyper Focus", 50),
                            buildStat("Pop Quiz", 25)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quiz",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "AvantGarde Bk BT",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Create a new quiz.",
                        style: TextStyle(
                          fontFamily: "SF Pro Text",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xff30DB5B),
                            borderRadius: BorderRadius.circular(13)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => CreateQuizScreen()),
                            );
                          },
                          child: const Text(
                            'Create quiz',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Insights",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "AvantGarde Bk BT",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Findings based on students Hyper Focus results",
                        style: TextStyle(
                          fontFamily: "SF Pro Text",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff1C1C1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            insightsWidget(
                                "Performance Rate",
                                "Average Minutes spent focused on the screen",
                                "30%",
                                "Live performance rate", []),
                            const SizedBox(
                              height: 32,
                            ),
                            insightsWidget(
                                "Attendance Rate",
                                "Minutes attended",
                                "30%",
                                "Live attendance rate", []),
                            const SizedBox(
                              height: 32,
                            ),
                            insightsWidget(
                                "Hyper Focus Rate",
                                "Average Minutes spent focused on the screen",
                                "30%",
                                "Live Hyper focus rate", []),
                            const SizedBox(
                              height: 32,
                            ),
                            insightsWidget(
                                "Pop Quiz",
                                "Pop quiz average results",
                                "30%",
                                "Average Rate Past 30 Days", []),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildStat(String text, double value) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 90,
        width: 90,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              showFirstLabel: false,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 70, endValue: 100, color: Colors.green),
                GaugeRange(startValue: 30, endValue: 70, color: Colors.orange),
                GaugeRange(startValue: 0, endValue: 30, color: Colors.red)
              ],
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: value,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text(
                      "$value%",
                      style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SF UI Display",
                          letterSpacing: -0.41,
                          color: Colors.white),
                    ),
                    verticalAlignment: GaugeAlignment.far,
                    angle: 90,
                    positionFactor: 0.5)
              ],
            )
          ],
        ),
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: "SF Pro Text",
          letterSpacing: -1.41,
        ),
      ),
    ],
  );
}

Widget insightsWidget(String keyIndicator, String description,
    String performance, String smallDescription, List<ChartData> dataList) {
  return Container(
    padding: const EdgeInsets.only(
      top: 16,
      right: 16,
      left: 16,
    ),
    child: Column(
      children: [
        Text(
          keyIndicator,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "SF Pro Display",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.35,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "SF Pro Text",
            fontSize: 14,
            fontWeight: FontWeight.normal,
            letterSpacing: -0.41,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          performance,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "SF Pro Display",
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.36,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          smallDescription,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "SF Pro Text",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.41,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: SfCartesianChart(
            //borderWidth: 0,
            plotAreaBorderWidth: 0,
            trackballBehavior: TrackballBehavior(
              activationMode: ActivationMode.singleTap,
              enable: true,
              tooltipSettings:
                  const InteractiveTooltip(enable: true, color: Colors.red),
            ),

            primaryXAxis: NumericAxis(
              maximum: 24,
              minimum: 0,
              isVisible: false,
              //axisLine: const AxisLine(width: 0),
              //majorGridLines: const MajorGridLines(width: 0),
            ),

            primaryYAxis: NumericAxis(
              maximum: 100,
              minimum: 0,
              axisLine: const AxisLine(width: 0),
              majorGridLines: const MajorGridLines(
                color: Color(0xff9797AA),
                width: 1.5,
              ),
            ),
            series: <LineSeries<ChartData, num>>[
              LineSeries<ChartData, num>(
                width: 8,
                color: Colors.green,
                dataSource: dataList,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class LiveData {
  LiveData(this.interval, this.data);
  final int interval;
  final double data;
}

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
class ChartData {
  ChartData({required this.x, required this.y});
  final int x;
  final int y;
}

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
