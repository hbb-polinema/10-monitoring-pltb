import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/monitoring_data.dart';
import 'package:manajemen_aset/service/http_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;
import 'dart:convert';

import 'package:http/http.dart' as http;

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late ChartSeriesController _chartSeriesController;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  // late Future<MonitoringData> chartData;
  List<MonitoringData> chartData = [];
  String url = 'https://ebt-polinema.id/api/wind-turbine/status';

  Future<MonitoringData> getRealData(String id, DateTime date, String draw) async {
    final http.Response res = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'real_data': [
          {'date': date.toIso8601String()}
        ],
        'calc_data': [
          {'date': date.toIso8601String()}
        ],
        'draw': draw
      }),
    );
    // return res.body;
    if (res.statusCode == 200) {
      return MonitoringData.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to get data.');
    }
  }

  // Future loadMonitorData() async {
  //   MonitoringData jsonString = await getRealData("1", DateTime.now(), "1");
  //   MonitoringData? monitoringDataFromJson(String str) =>
  //       MonitoringData.fromJson(json.decode(jsonString));
  //   final monitoringData = monitoringDataFromJson(jsonString);
  //   final data = jsonDecode(jsonString);
  //   print(monitoringDataFromJson);
  //   setState(
  //     () {
  //       for (Map<String, dynamic> i in monitoringDataFromJson) {
  //         chartData.add(MonitoringData.fromJson(i));
  //       }
  //     },
  //   );
  // }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
    // loadMonitorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getRealData("1", DateTime.now(), "1"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // var listData = snapshot.data!['real_data'];
            // return Text(snapshot.data);
            // final list = json
            //     .decode(get)['real_data']
            //     .map((data) => MonitoringData.fromJson(data))
            //     .toList();
            return SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              series: <ChartSeries>[
                // StackedLineSeries<MonitoringData, dynamic>(
                //   dataSource: chartData,
                //   color: const Color.fromARGB(255, 212, 41, 41),
                //   xValueMapper: (MonitoringData val, _) =>
                //       val.realData!.asMap(),
                //   yValueMapper: (MonitoringData val, _) => val.id,
                // ),
              ],

              // StackedLineSeries<MonitoringData, int>(
              //   onRendererCreated: (ChartSeriesController controller) {
              //     _chartSeriesController = controller;
              //   },
              //   dataSource: chartData,
              //   color: Color.fromARGB(255, 212, 41, 41),
              //   xValueMapper: (MonitoringData dataa, _) => sales.time,
              //   yValueMapper: (MonitoringData dataa, _) => sales.speed,
              // ),

              // StackedLineSeries<MonitoringData, dynamic>(
              //   onRendererCreated: (ChartSeriesController controller) {
              //     _chartSeriesController = controller;
              //   },
              // dataSource: chartData,
              // color: Color.fromARGB(255, 252, 237, 109),
              // xValueMapper: (MonitoringData val, _) => val.(real_data, i) {
              // yValueMapper: (MonitoringData val, _) => val.realData,
              // ),
              // StackedLineSeries<MonitoringData, int>(
              //     onRendererCreated: (ChartSeriesController controller) {
              //       _chartSeriesController = controller;
              //     },
              //     dataSource: chartData,
              //     color: Color.fromARGB(255, 212, 41, 41),
              //     xValueMapper: (MonitoringData val, _) => val.id,
              //     yValueMapper: (MonitoringData val, _) => val.draw),

              primaryXAxis: NumericAxis(
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 3,
                // title: AxisTitle(text: ''),
              ),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                title: AxisTitle(text: 'kW'),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


    // return SfCartesianChart(
    //     tooltipBehavior: _tooltipBehavior,
    //     zoomPanBehavior: _zoomPanBehavior,
    //     series: <StackedLineSeries<MonitoringData, int>>[
          // StackedLineSeries<MonitoringData, int>(
          //   onRendererCreated: (ChartSeriesController controller) {
          //     _chartSeriesController = controller;
          //   },
          //   dataSource: chartData,
          //   color: Color.fromARGB(255, 252, 237, 109),
          //   xValueMapper: (MonitoringData dataa, _) => dataa.nextDate,
          //   yValueMapper: (MonitoringData dataa, _) => sales.speed,
          // ),
          // StackedLineSeries<MonitoringData, int>(
          //   onRendererCreated: (ChartSeriesController controller) {
          //     _chartSeriesController = controller;
          //   },
          //   dataSource: chartData,
          //   color: Color.fromARGB(255, 212, 41, 41),
          //   xValueMapper: (MonitoringData dataa, _) => sales.time,
          //   yValueMapper: (MonitoringData dataa, _) => sales.speed,
          // ),
        // ],
        // primaryXAxis: NumericAxis(
        //     majorGridLines: const MajorGridLines(width: 0),
        //     edgeLabelPlacement: EdgeLabelPlacement.shift,
        //     interval: 3,
        //     title: AxisTitle(text: 'Time (seconds)')),
        // primaryYAxis: NumericAxis(
        //     axisLine: const AxisLine(width: 0),
        //     majorTickLines: const MajorTickLines(size: 0),
        //     title: AxisTitle(text: 'Internet speed (Mbps)')));
  // }

  // int time = 19;
  // void updateDataSource(Timer timer) {
  //   chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30),
  //       (math.Random().nextInt(60) + 30)));
  //   chartData.removeAt(0);
  //   _chartSeriesController.updateDataSource(
  //       addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  // }

//   List<LiveData> getChartData() {
//     return <LiveData>[
//       LiveData(0, 42, 22),
//       LiveData(1, 47, 26),
//       LiveData(2, 43, 29),
//       LiveData(3, 49, 29),
//       LiveData(4, 54, 24),
//       LiveData(5, 41, 21),
//       LiveData(6, 58, 20),
//       LiveData(7, 51, 23),
//       LiveData(8, 98, 22),
//       LiveData(9, 41, 22),
//       LiveData(10, 53, 22),
//       LiveData(11, 72, 22),
//       LiveData(12, 86, 22),
//       LiveData(13, 52, 22),
//       LiveData(14, 94, 22),
//       LiveData(15, 92, 22),
//       LiveData(16, 86, 22),
//       LiveData(17, 72, 22),
//       LiveData(18, 94, 22)
//     ];
//   }
// }

// class LiveData {
//   LiveData(this.time, this.speed, this.speed2);
//   final int time;
//   final num speed;
//   final num speed2;
// }

// class MonitoringData {
//   MonitoringData(this.time, this.realData, this.calcData);
//   final String time;
//   final double realData;
//   final double calcData;
// }
