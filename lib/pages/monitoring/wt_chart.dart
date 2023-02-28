import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/realtime_energy.dart';
import 'package:manajemen_aset/models/solar_panel.dart';
import 'package:manajemen_aset/models/wind_turbine.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class WtChart extends StatefulWidget {
  const WtChart({Key? key}) : super(key: key);

  @override
  _WtChartState createState() => _WtChartState();
}

class _WtChartState extends State<WtChart> {
  // final List<WtData> _data = [];
  // final List<SpData> _chartSpData = [];
  final List<RealtimeEnergy> _dataReal = [];
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

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
    // _chartSpData = getSpData();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!));
    // fetchDataSp();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
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
    Uri url = Uri.parse("https://ebt-polinema.id/api/wind-turbine/history");
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
        _dataReal.clear();
        for (var dataReal in jsonData) {
          _dataReal.add(
            RealtimeEnergy(
              dataReal['date_utc'] != null
                  ? DateFormat('HH:mm')
                      .format(DateTime.parse(dataReal['date_utc']))
                  : '',
              (dataReal['volt_dc']?.toDouble() ?? 0.0) *
                  (dataReal['ampere_dc']?.toDouble() ?? 0.0),
              0,
              dataReal['wind_speed']?.toDouble() ?? 0.0,
              double.parse(dataReal['rpm_1']),
              double.parse(dataReal['rpm_2']),
              dataReal['volt_dc']?.toDouble() ?? 0.0,
              dataReal['ampere_dc']?.toDouble() ?? 0.0,
              0,
            ),
          );
          // _data.add(
          //   WtData(
          //     data['date_utc'] != null
          //         ? DateFormat('HH:mm').format(DateTime.parse(data['date_utc']))
          //         : '',
          //     data['wind_speed']?.toDouble() ?? 0.0,
          //     data['wind_dir'] ?? '',
          //     data['rpm_1'] ?? '',
          //     data['rpm_2'] ?? '',
          //     data['voltAc']?.toDouble() ?? 0.0,
          //     data['voltDc']?.toDouble() ?? 0.0,
          //     data['AmpereAc']?.toDouble() ?? 0.0,
          //     data['AmpereDc']?.toDouble() ?? 0.0,
          //     data['temp_1']?.toDouble() ?? 0.0,
          //     data['temp_2']?.toDouble() ?? 0.0,
          //     data['vibraVolt1']?.toDouble() ?? 0.0,
          //     data['vibraFreq1'] ?? '',
          //     data['vibraVolt2']?.toDouble() ?? 0.0,
          //     data['vibraFreq2'] ?? '',
          //     data['vibraVolt3']?.toDouble() ?? 0.0,
          //     data['vibraFreq3'] ?? '',
          //     data['vibraVolt4']?.toDouble() ?? 0.0,
          //     data['vibraFreq4'] ?? '',
          //     data['noiseVolt']?.toDouble() ?? 0.0,
          //     data['noiseFreq'] ?? '',
          //     data['velo1'] ?? '',
          //     data['velo2'] ?? '',
          //     data['gyroX']?.toDouble() ?? 0.0,
          //     data['gyroY']?.toDouble() ?? 0.0,
          //     data['gyroZ']?.toDouble() ?? 0.0,
          //     (data['voltAc']?.toDouble() ?? 0.0) *
          //         (data['AmpereAc']?.toDouble() ?? 0.0),
          //   ),
          // );
        }
      });
    }
  }

  // Future<void> fetchDataSp() async {
  //   Uri url2 =
  //       Uri.parse("https://mocki.io/v1/04094d49-48c7-4b05-a5a5-2427b29c2638");
  //   var response2 = await http.get(url2);
  //   final jsonDataSp = json.decode(response2.body);
  //   if (mounted) {
  //     setState(() {
  //       _chartSpData.clear();
  //       for (var dataSp in jsonDataSp) {
  //         _chartSpData.add(SpData(
  //           dataSp['date_utc'] != null
  //               ? DateFormat('HH:mm').format(DateTime.parse(dataSp['date_utc']))
  //               : '',
  //           dataSp['solar_rad']?.toDouble() ?? 0.0,
  //           dataSp['power']?.toDouble() ?? 0.0,
  //         ));
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return (_dataReal.isNotEmpty)
        ? Column(
            children: [
              //date
              datePicker(),
              const Divider(thickness: 1),
              const SizedBox(
                height: 8,
              ),
              SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                trackballBehavior: _trackballBehavior,
                legend: Legend(
                  isVisible: true,
                  height: '50%',
                  width: '100%',
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
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
                series: <ChartSeries<dynamic, dynamic>>[
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Volt Dc',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(223, 78, 250, 207),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.voltDc,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Ampere Dc',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(223, 78, 250, 87),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.ampereDc,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Power PLTB',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 248, 56, 56),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.powerWt,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Wind Speed',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(225, 0, 74, 173),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.windSpeed,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.triangle,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'RPM Generator',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(223, 250, 78, 227),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.rpm1,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'RPM Bilah',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(223, 247, 250, 78),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.rpm2,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Power PLTS',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(224, 0, 173, 43),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.powerSp,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Solar Radiation',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(223, 230, 172, 14),
                    xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
                    yValueMapper: (RealtimeEnergy data, _) => data.solarRad,
                    yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.triangle,
                      height: 5,
                      width: 5,
                    ),
                  ),
                ],
              ),
            ],
          )
        : datePicker();
  }

  Row datePicker() {
    return Row(
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
    );
  }
}
