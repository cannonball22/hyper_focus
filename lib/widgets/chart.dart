import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<SensorValue> _data;

  Chart(this._data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.black,
    );
  }
}

/*
    return new charts.TimeSeriesChart([
      charts.Series<SensorValue, DateTime>(
        id: 'Values',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (SensorValue values, _) => values.time,
        measureFn: (SensorValue values, _) => values.value,
        data: _data,
      )
    ],
        animate: false,
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(zeroBound: false),
          renderSpec: charts.NoneRenderSpec(),
        ),
        domainAxis: new charts.DateTimeAxisSpec(
            renderSpec: new charts.NoneRenderSpec()));
  }
}
*/
class SensorValue {
  final DateTime time;
  final double value;

  SensorValue(this.time, this.value);
}
