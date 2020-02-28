import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimeSeriesAccount {
  final DateTime date;
  final double accountValue;
  TimeSeriesAccount(this.date, this.accountValue);
}

List<TimeSeriesAccount> sampleAccount = [
  TimeSeriesAccount(DateTime(2020, 1, 1), 50000.00),
  TimeSeriesAccount(DateTime(2020, 1, 2), 46039.29),
  TimeSeriesAccount(DateTime(2020, 1, 3), 46000.77),
  TimeSeriesAccount(DateTime(2020, 1, 4), 35722.50),
  TimeSeriesAccount(DateTime(2020, 1, 5), 30728.00),
  TimeSeriesAccount(DateTime(2020, 1, 6), 17008.01),
  TimeSeriesAccount(DateTime(2020, 1, 7), 50500.00),
  TimeSeriesAccount(DateTime(2020, 1, 8), 45300.10),
  TimeSeriesAccount(DateTime(2020, 1, 9), 45220.63),
  TimeSeriesAccount(DateTime(2020, 1, 10), 23375.63),
  TimeSeriesAccount(DateTime(2020, 1, 11), 17438.89)
];

class SevenDaysChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  // Make sure to learn how this animate thing works haha
  // final bool animate;

  SevenDaysChart({@required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: false,
      dateTimeFactory: charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            day: charts.TimeFormatterSpec(
                // This formats it as MON TUE WED etc.
                format: "EEE",
                transitionFormat: "EEE")),
        // This causes the chart to show a tick for every daily increment
        tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
            // This will try to give you your desired number of ticker on the y axis
            desiredTickCount: 10),
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            (value) => "\$${value.toStringAsFixed(0)}"),
      ),
    );
  }

  factory SevenDaysChart.withSampleData() {
    return SevenDaysChart(
      seriesList: _createSampleData(),
    );
  }

  static List<charts.Series<TimeSeriesAccount, DateTime>> _createSampleData() {
    return [
      charts.Series<TimeSeriesAccount, DateTime>(
          domainFn: (datum, index) => datum.date, // This is the x axis, DOMAIN!
          measureFn: (datum, index) => datum.accountValue, // y axis, measure
          data: sampleAccount,
          id: "Sample 7 Day Series")
    ];
  }
}
