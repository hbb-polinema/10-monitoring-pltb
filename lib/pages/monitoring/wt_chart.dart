import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/wind_turbine.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class WtChart extends StatefulWidget {
  final String idWt;
  const WtChart({Key? key, required this.idWt}) : super(key: key);

  @override
  _WtChartState createState() => _WtChartState();
}

class _WtChartState extends State<WtChart> {
  List<WtData> _dataWt = [];
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
        fetchFuture =
            fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt);
      });
    });
  }

  late Future fetchFuture;

  @override
  void initState() {
    super.initState();
    fetchFuture =
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt);
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
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
  Future fetchData(String date, String id) async {
    Uri url =
        Uri.parse("https://ebt-polinema.id/api/wind-turbine/power-status");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> prodKwh = jsonData['prod_kwh'];

    List<WtData> dataWt = [];

    for (var i = 0; i < prodKwh.length; i++) {
      var dateUtc =
          DateFormat('HH:mm:ss').format(DateTime.parse(prodKwh[i]['date_utc']));
      var windSpeed = prodKwh[i]['wind_speed']?.toDouble() ?? 0.0;
      var rpmBilah = prodKwh[i]['rpm_bilah']?.toDouble() ?? 0.0;
      var rpmGenerator = prodKwh[i]['rpm_generator']?.toDouble() ?? 0.0;
      var powerAc = prodKwh[i]['power_ac']?.toDouble() ?? 0.0;
      var powerDc = prodKwh[i]['power_dc']?.toDouble() ?? 0.0;

      dataWt.add(WtData(
        dateUtc,
        windSpeed,
        rpmBilah,
        rpmGenerator,
        powerAc,
        powerDc,
      ));
    }

    // if (mounted) {
    //   setState(() {
    //     _dataWt = dataWt;
    //   });
    // }
    return _dataWt = dataWt;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: Future.delayed(
      //     const Duration(seconds: 2),
      //     () => fetchData(
      //         DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWt)),
      future: fetchFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
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
                  series: <ChartSeries<WtData, dynamic>>[
                    SplineSeries<WtData, dynamic>(
                      name: 'Power AC (W)',
                      dataSource: _dataWt,
                      enableTooltip: true,
                      color: const Color.fromARGB(225, 0, 74, 173),
                      xValueMapper: (WtData data, _) => data.dateUtc,
                      yValueMapper: (WtData data, _) => data.powerAc,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        height: 5,
                        width: 5,
                      ),
                    ),
                    SplineSeries<WtData, dynamic>(
                      name: 'Power DC (W)',
                      dataSource: _dataWt,
                      enableTooltip: true,
                      color: const Color.fromARGB(224, 173, 0, 29),
                      xValueMapper: (WtData data, _) => data.dateUtc,
                      yValueMapper: (WtData data, _) => data.powerDc,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        height: 5,
                        width: 5,
                      ),
                    ),
                    SplineSeries<WtData, dynamic>(
                      name: 'Wind Speed (m/s)',
                      dataSource: _dataWt,
                      enableTooltip: true,
                      color: const Color.fromARGB(224, 255, 152, 34),
                      xValueMapper: (WtData data, _) => data.dateUtc,
                      yValueMapper: (WtData data, _) => data.windSpeed,
                      yAxisName: 'yAxis',
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.triangle,
                        height: 5,
                        width: 5,
                      ),
                    ),
                    SplineSeries<WtData, dynamic>(
                      name: 'Rpm Bilah',
                      dataSource: _dataWt,
                      enableTooltip: true,
                      color: const Color.fromARGB(224, 190, 27, 223),
                      xValueMapper: (WtData data, _) => data.dateUtc,
                      yValueMapper: (WtData data, _) => data.rpmBilah,
                      yAxisName: 'yAxis',
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        height: 5,
                        width: 5,
                      ),
                    ),
                    SplineSeries<WtData, dynamic>(
                      name: 'Rpm Generator',
                      dataSource: _dataWt,
                      enableTooltip: true,
                      color: const Color.fromARGB(255, 27, 223, 102),
                      xValueMapper: (WtData data, _) => data.dateUtc,
                      yValueMapper: (WtData data, _) => data.rpmGenerator,
                      // yAxisName: 'yAxis',
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        height: 5,
                        width: 5,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        }
      },
    );
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_month_rounded),
            Text(_dateTime == null
                ? DateFormat('dd MM yyyy HH:mm').format(DateTime.now())
                : DateFormat('dd MMM yyyy HH:mm').format(_dateTime!)),
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
