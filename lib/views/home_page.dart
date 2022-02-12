import 'package:flutter/material.dart';
import 'package:andromeda/services/service.dart';
import 'componets/all_componets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
    title: Text('Dashboard'),
    ),
    body:Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<AppService>(context).getLatestWeight(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return MeasurementCard(
                        title: 'Weight',
                        color: Color(0xFFA5D6A7),
                        measurement: snapshot.data,
                      );
                    } else {
                      return const MeasurementCard(
                        title: 'Weight',
                        color: Color(0xFFA5D6A7),
                        measurement: null,
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<AppService>(context).getLatestHeight(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return MeasurementCard(
                        title: 'Height',
                        color: Color(0xFFA5D6A7),
                        measurement: snapshot.data,
                      );
                    } else {
                      return const MeasurementCard(
                        title: 'Height',
                        color: Color(0xFFA5D6A7),
                        measurement: null,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<AppService>(context).getLatestBmi(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return BmiCard(
                        color: Color(0xFFCDDC39),
                        bmiMeasurement: snapshot.data,
                      );
                    }else{
                      return const BmiCard(
                        color: Color(0xFFCDDC39),
                        bmiMeasurement: null,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    )
    );
  }
}
