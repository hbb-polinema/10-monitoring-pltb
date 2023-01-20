import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SelectedDateChart extends StatefulWidget {
  const SelectedDateChart({Key? key}) : super(key: key);

  @override
  State<SelectedDateChart> createState() => _SelectedDateChartState();
}

class _SelectedDateChartState extends State<SelectedDateChart> {
  List<TurbineData> _chartData = [];
  // late ChartSeriesController _chartSeriesController;
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    fetchSelected();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future fetchSelected() async {
    _chartData = await getDataSelect;
    if (mounted) {
      setState(() {});
    }
  }

  Future connectAPI(String date) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/wind-turbine/status");
    var response = await http.post(
      url,
      body: {"id": "1", "date": date, "draw": "2"},
    );
    var data = json.decode(response.body);
    return data;
  }

  DateTime? dateTime = DateTime.now();

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.dateTime = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_chartData.isNotEmpty)
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //lokasi
                  Row(
                    children: [
                      const Icon(Icons.place),
                      const Text('Location'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.expand_more),
                      ),
                    ],
                  ),
                  //date
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded),
                      Text(dateTime == null
                          ? DateFormat('dd MM yyyy HH:mm')
                              .format(DateTime.now())
                          : DateFormat('dd MMM yyyy HH:mm').format(dateTime!)),
                      IconButton(
                        onPressed: () async {
                          pickDateTime();
                        },
                        icon: const Icon(Icons.expand_more),
                      ),
                    ],
                  ),
                ],
              ),
              SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    overflowMode: LegendItemOverflowMode.wrap),
                primaryXAxis: CategoryAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 3,
                ),
                series: <SplineSeries<TurbineData, dynamic>>[
                  SplineSeries<TurbineData, dynamic>(
                    name: 'Pengukuran',
                    dataSource: _chartData,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 253, 223, 56),
                    xValueMapper: (TurbineData data, _) => data.date,
                    yValueMapper: (TurbineData data, _) => data.value,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<TurbineData, dynamic>(
                    name: 'Perhitungan',
                    dataSource: _chartData,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 248, 56, 56),
                    xValueMapper: (TurbineData data, _) => data.calcDate,
                    yValueMapper: (TurbineData data, _) => data.calcValue,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 120,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      fetchSelected();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.refresh),
                        Text(
                          "Refresh",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  Future<List<TurbineData>> get getDataSelect async {
    List<double> data = [];
    List<String> date = [];
    List<double> calcData = [];
    List<String> calcDate = [];

    for (var i = 0; i < 10; i++) {
      var currSecs = 00;
      if (currSecs % 5 != 0) {
        currSecs = currSecs - (currSecs % 5);
      }
      var newSecs = currSecs - i * 5;
      var secs = '';
      var min = 0;

      if (newSecs < 0) {
        newSecs = 60 + newSecs;
        min = 1;
      }

      if (newSecs < 10) {
        secs = "0$newSecs";
      } else {
        secs = newSecs.toString();
      }
      await connectAPI(DateFormat("yyyy-MM-dd HH:mm:$secs")
              .format(dateTime!.subtract(Duration(minutes: min)))
              .toString())
          .then((value) {
        data.add(value['real_data'][0]["value"] + 0.0);
        date.add(value['real_data'][0]["date"]);
        calcData.add(value['calc_data'][0]["value"] + 0.0);
        calcDate.add(value['calc_data'][0]["date"]);
      });
    }

    final List<TurbineData> chartData = [
      TurbineData(date[9].substring(10, date[9].length), data[9],
          calcDate[9].substring(10, date[9].length), calcData[9]),
      TurbineData(date[8].substring(10, date[8].length), data[8],
          calcDate[8].substring(10, date[8].length), calcData[8]),
      TurbineData(date[7].substring(10, date[7].length), data[7],
          calcDate[7].substring(10, date[7].length), calcData[7]),
      TurbineData(date[6].substring(10, date[6].length), data[6],
          calcDate[6].substring(10, date[6].length), calcData[6]),
      TurbineData(date[5].substring(10, date[5].length), data[5],
          calcDate[5].substring(10, date[5].length), calcData[5]),
      TurbineData(date[4].substring(10, date[4].length), data[4],
          calcDate[4].substring(10, date[4].length), calcData[4]),
      TurbineData(date[3].substring(10, date[3].length), data[3],
          calcDate[3].substring(10, date[3].length), calcData[3]),
      TurbineData(date[2].substring(10, date[2].length), data[2],
          calcDate[2].substring(10, date[2].length), calcData[2]),
      TurbineData(date[1].substring(10, date[1].length), data[1],
          calcDate[1].substring(10, date[1].length), calcData[1]),
      TurbineData(date[0].substring(10, date[0].length), data[0],
          calcDate[0].substring(10, date[0].length), calcData[0]),
    ];
    return chartData;
  }
}

class TurbineData {
  TurbineData(this.date, this.value, this.calcDate, this.calcValue);
  String date;
  double value;
  String calcDate;
  double calcValue;
}
