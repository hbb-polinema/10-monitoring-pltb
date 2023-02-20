import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final List<WeatherData> _data = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  DateTime? _dateTime = DateTime.now();
  // menampilkan date picker
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        _dateTime = _dateTime;
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!));
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // mangambil data
  Future<void> fetchData(String date) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/weather-station/history");
    // Uri url=Uri.parse("127.0.0.1:1880/w/history");
    var response = await http.post(
      url,
      body: {
        "id": "1",
        "date": date,
      },
    );
    final jsonData = json.decode(response.body);

    if (mounted) {
      setState(() {
        _data.clear();
        for (var data in jsonData) {
          _data.add(WeatherData(
              DateFormat('HH:mm').format(DateTime.parse(data['date_utc'])),
              data['wind_speed'].toDouble(),
              data['wind_dir'].toDouble(),
              data['temp'].toDouble()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_data.isNotEmpty)
        ? Column(
            children: [
              //date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.place),
                      const Text('Tuban'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.expand_more),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded),
                      Text(_dateTime == null
                          ? DateFormat('dd MM yyyy').format(DateTime.now())
                          : DateFormat('dd MMM yyyy').format(_dateTime!)),
                      IconButton(
                        onPressed: () async {
                          _showDatePicker();
                        },
                        icon: const Icon(Icons.expand_more),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 1),
              const SizedBox(
                height: 8,
              ),
              SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    overflowMode: LegendItemOverflowMode.wrap),
                axes: <ChartAxis>[
                  NumericAxis(
                    name: 'yAxis',
                    // title: AxisTitle(
                    //   text: 'm/s',
                    //   textStyle: const TextStyle(fontSize: 12),
                    // ),
                    opposedPosition: true,
                    interval: 5,
                  )
                ],
                primaryXAxis: CategoryAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 3,
                ),
                series: <ChartSeries<WeatherData, dynamic>>[
                  SplineSeries<WeatherData, dynamic>(
                    name: 'Ukur',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 253, 223, 56),
                    xValueMapper: (WeatherData data, _) => data.dateUtc,
                    yValueMapper: (WeatherData data, _) => data.windSpeed,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 3,
                      width: 3,
                    ),
                  ),
                  SplineSeries<WeatherData, dynamic>(
                    name: 'Hitung',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 248, 56, 56),
                    xValueMapper: (WeatherData data, _) => data.dateUtc,
                    yValueMapper: (WeatherData data, _) => data.windDir,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<WeatherData, dynamic>(
                    name: 'Angin',
                    dataSource: _data,
                    enableTooltip: true,
                    color: const Color.fromARGB(225, 0, 74, 173),
                    xValueMapper: (WeatherData data, _) => data.dateUtc,
                    yValueMapper: (WeatherData data, _) => data.temp,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                ],
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}

// model
class WeatherData {
  String dateUtc;
  double windSpeed;
  double windDir;
  double temp;
  // double uvIndex;
  // double solarRad;

  WeatherData(
    this.dateUtc,
    this.windSpeed,
    this.windDir,
    this.temp,
    // this.uvIndex,
    // this.solarRad,
  );
}
