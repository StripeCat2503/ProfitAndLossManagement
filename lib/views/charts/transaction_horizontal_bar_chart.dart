import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pnL/chart_data/transaction_chart_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TransactionChart extends StatelessWidget {
  List<TransactionChartData> data;

  TransactionChart({this.data});

  List<charts.Series<TransactionChartData, String>> _getSeries() {
    return [
      // expense series
      charts.Series<TransactionChartData, String>(
        data: [this.data[0]],
        domainFn: (datum, index) =>
            datum.transactionType.toString().split('.')[1],
        measureFn: (datum, index) => datum.balance,
        seriesColor: charts.MaterialPalette.gray.shadeDefault,
      ),
      // revenue series
      charts.Series<TransactionChartData, String>(
        data: [this.data[1]],
        domainFn: (datum, index) =>
            datum.transactionType.toString().split('.')[1],
        measureFn: (datum, index) => datum.balance,
        seriesColor: charts.MaterialPalette.green.shadeDefault,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final simpleCurrencyFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
      NumberFormat.compactSimpleCurrency(locale: 'vi-VN'),
    );

    return charts.BarChart(
      _getSeries(),
      animate: true,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      primaryMeasureAxis:
          charts.NumericAxisSpec(tickFormatterSpec: simpleCurrencyFormatter),
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }
}
