import 'package:andromeda/models/all_models.dart';
import 'package:andromeda/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/componets/all_componets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);


  String _formatDate(String stringDate){
    final inputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(stringDate);
    final outputFormat = DateFormat('d MMM');
    return outputFormat.format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'February 2022 Weights',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 6,
              child: SimpleLineChart.withSampleData(),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<AppService>(context).getMinMaxWeight(),
                  builder:
                      (context, AsyncSnapshot<dynamic> snapshot) {
                    print('building');
                    if (snapshot.connectionState==ConnectionState.done) {
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
                        children: [
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
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate = false});

  factory SimpleLineChart.withSampleData() {
    return new SimpleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  String xAxisTickFormatter(num? value) {
    if (value == 0) {
      return "1 FEB";
    } else if (value == 1) {
      return "2 FEB";
    } else if (value == 2) {
      return "3 FEB";
    } else if (value == 3) {
      return "4 FEB";
    } else if (value == 4) {
      return "5 FEB";
    } else if (value == 5) {
      return "6 FEB";
    } else if (value == 6) {
      return "7 FEB";
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final customTickFormatter =
        charts.BasicNumericTickFormatterSpec(xAxisTickFormatter);

    return charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer:
          charts.LineRendererConfig(includePoints: true, includeArea: true),
      primaryMeasureAxis: charts.NumericAxisSpec(
        showAxisLine: true,
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 6, zeroBound: false),
      ),
      domainAxis: charts.NumericAxisSpec(
        showAxisLine: true,
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 3, zeroBound: false),
        tickFormatterSpec: customTickFormatter,
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearWeights, int>> _createSampleData() {
    final data = [
      LinearWeights(0, 12),
      LinearWeights(1, 1),
      LinearWeights(2, 4),
      LinearWeights(3, 7),
      LinearWeights(4, 5),
    ];
    var shadowColor = charts.Color(r: 240, g: 246, b: 244, a: 160);
    var primaryThemeColor = charts.Color.fromHex(code: "#00695C");
    return [
      new charts.Series<LinearWeights, int>(
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
