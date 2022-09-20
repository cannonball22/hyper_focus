import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget buildStat(String text, int value, BuildContext context) {
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
                  value <= 30
                      ? GaugeRange(
                          startValue: 0,
                          endValue: value.toDouble(),
                          color: Colors.red)
                      : (value > 30 && value <= 70)
                          ? GaugeRange(
                              startValue: 0,
                              endValue: value.toDouble(),
                              color: Colors.orange)
                          : GaugeRange(
                              startValue: 0,
                              endValue: value.toDouble(),
                              color: Colors.green)
                ],
                pointers: <GaugePointer>[
                  MarkerPointer(
                    value: value.toDouble(),
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text(
                        "$value%",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SF UI Display",
                            letterSpacing: -0.41,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      verticalAlignment: GaugeAlignment.far,
                      angle: 90,
                      positionFactor: 0.5)
                ],
              )
            ],
          )),
      Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: "SF Pro Text",
          letterSpacing: -1.41,
        ),
      ),
    ],
  );
}

Widget insightsWidget(
    String keyIndicator,
    String description,
    String performance,
    String smallDescription,
    List<ChartData> dataList,
    BuildContext context) {
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
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
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
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
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
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
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
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
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

class ChartData {
  ChartData({required this.x, required this.y});
  final int x;
  final int y;
}
