import 'package:andromeda/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/componets/all_componets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:andromeda/models/all_models.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  String _formatDate(String stringDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(stringDate);
    final outputFormat = DateFormat('d MMM');
    return outputFormat.format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'This Month Weights',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 6,
              child: FutureBuilder(
                  future:
                      Provider.of<AppService>(context).getThisMonthWeights(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data.length > 1) {
                      return SimpleLineChart(
                        measurements: snapshot.data,
                      );
                    } else {
                      return Column(
                        children: [
                          Text('No Data Yet!'),
                          Text('Only latest reading in a day are recorded.'),
                          Text('Chart appears with at least two readings.'),
                        ],
                      );
                    }
                  }),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<AppService>(context).getMinMaxWeight(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data.length > 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MinMaxContainer(
                            title: 'Maximum',
                            value: snapshot.data[0].value.toString(),
                            date: _formatDate(snapshot.data[0].date),
                            color: Colors.red,
                            unit: snapshot.data[0].unit.name,
                          ),
                          MinMaxContainer(
                            title: 'Minimum',
                            value: snapshot.data[1].value.toString(),
                            date: _formatDate(snapshot.data[1].date),
                            color: Colors.blue,
                            unit: snapshot.data[1].unit.name,
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          MinMaxContainer(
                              title: 'Maximum',
                              value: null,
                              date: null,
                              color: Colors.red,
                              unit: null),
                          MinMaxContainer(
                              title: 'Minimum',
                              value: null,
                              date: null,
                              color: Colors.blue,
                              unit: null),
                        ],
                      );
                    }
                  }),
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}

class SimpleLineChart extends StatelessWidget {
  final bool animate;
  List<Measurement> measurements;
  Map _labelRouter = {};

  SimpleLineChart({required this.measurements, this.animate = false}) {
    _labelRouter = generateLabelRouter();
  }

  Map generateLabelRouter() {
    Map<int, String> labelRouter = {};

    for (int i = 1; i <= 31; i++) {
      labelRouter[i] = '$i ${_getMonthName(measurements[0].date)}';
    }

    return labelRouter;
  }

  String xAxisTickFormatter(num? value) {
    if (_labelRouter.containsKey(value?.toInt())) {
      return _labelRouter[value?.toInt()] ?? '';
    } else {
      return '';
    }
  }

  List<LinearWeights> generateChartData() {
    return List.generate(measurements.length, (index) {
      return LinearWeights(
        _getDayDigit(measurements[index].date),
        measurements[index].value.toInt(),
      );
    });
  }

  String _getMonthName(String stringDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(stringDate);
    final outputFormat = DateFormat('MMM');
    return outputFormat.format(inputDate);
  }

  int _getDayDigit(String stringDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(stringDate);
    final outputFormat = DateFormat('d');
    return int.parse(outputFormat.format(inputDate));
  }

  @override
  Widget build(BuildContext context) {
    final customTickFormatter =
        charts.BasicNumericTickFormatterSpec(xAxisTickFormatter);

    return charts.LineChart(
      _createSampleData(generateChartData()),
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
        includeArea: false,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        // showAxisLine:fals
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: (MediaQuery.of(context).platformBrightness==Brightness.dark)?charts.Color.white:charts.Color.black,
          ),
        ),
        showAxisLine: true,
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          desiredTickCount: 6,
          zeroBound: false,
        ),
      ),
      domainAxis: charts.NumericAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: (MediaQuery.of(context).platformBrightness==Brightness.dark)?charts.Color.white:charts.Color.black,
          ),
        ),
        showAxisLine: true,
        tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          desiredTickCount: 3,
          zeroBound: false,
        ),
        tickFormatterSpec: customTickFormatter,
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearWeights, int>> _createSampleData(
      List<LinearWeights> data) {
    var shadowColor = const charts.Color(r: 240, g: 246, b: 244, a: 160);
    var primaryThemeColor = charts.Color.fromHex(code: "#00695C");
    return [
      charts.Series<LinearWeights, int>(
        id: 'Weights',
        domainFn: (LinearWeights weights, _) => weights.date,
        measureFn: (LinearWeights weights, _) => weights.weight,
        colorFn: (_, __) => primaryThemeColor,
        areaColorFn: (_, __) => shadowColor,
        data: data,
      )
    ];
  }
}

class LinearWeights {
  final int date;
  final int weight;

  LinearWeights(this.date, this.weight);
}
