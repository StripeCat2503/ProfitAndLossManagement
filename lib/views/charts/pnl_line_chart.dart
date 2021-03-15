import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pnL/chart_data/transaction_chart_data.dart';
import 'package:pnL/enums/transaction_type.dart';

class PnlLineChart extends StatelessWidget {
  List<TransactionChartData> data;

  PnlLineChart({this.data});

  List<charts.Series<TransactionChartData, DateTime>> _getSeries() {
    return [
      charts.Series<TransactionChartData, DateTime>(
        data: this
            .data
            .where((d) => d.transactionType == TransactionTypeEnum.Revenues)
            .toList(),
        domainFn: (datum, index) => datum.createdDate,
        measureFn: (datum, index) => datum.balance,
        seriesColor: charts.MaterialPalette.green.shadeDefault,
        displayName: 'Revenues',
      ),
      charts.Series<TransactionChartData, DateTime>(
          data: this
              .data
              .where((d) => d.transactionType == TransactionTypeEnum.Expenses)
              .toList(),
          domainFn: (datum, index) => datum.createdDate,
          measureFn: (datum, index) => datum.balance,
          seriesColor: charts.MaterialPalette.gray.shade700,
          displayName: 'Expenses')
    ];
  }

  @override
  Widget build(BuildContext context) {
    final simpleCurrencyFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
      NumberFormat.compactSimpleCurrency(locale: 'vi-VN'),
    );
    return charts.TimeSeriesChart(
      _getSeries(),
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      domainAxis: charts.DateTimeAxisSpec(
          viewport: charts.DateTimeExtents(
            // config start time and end time in x-axis of chart
            start: DateTime(2020, 1, 1),
            end: DateTime(2020, 6, 1),
          ),
          showAxisLine: true,
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            month: charts.TimeFormatterSpec(
                format: 'MMM', transitionFormat: 'MMM'),
          )),
      primaryMeasureAxis:
          charts.NumericAxisSpec(tickFormatterSpec: simpleCurrencyFormatter),
    );
  }
}
