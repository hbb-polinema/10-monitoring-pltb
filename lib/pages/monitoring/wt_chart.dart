import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/realtime_energy.dart';
import 'package:manajemen_aset/models/wind_turbine.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class WtChart extends StatefulWidget {
  final String idWs;
  const WtChart({Key? key, required this.idWs}) : super(key: key);

  @override
  _WtChartState createState() => _WtChartState();
}

class _WtChartState extends State<WtChart> {
  List<RealtimeEnergy> _dataReal = [];
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
        fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM-dd').format(_dateTime!), widget.idWs);
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
  Future<void> fetchData(String date, String id) async {
    Uri url = Uri.parse("https://ebt-polinema.id/api/wind-turbine/status");
    var response = await http.post(
      url,
      body: {"id": id, "date": date, "draw": "1"},
    );
    final jsonData = json.decode(response.body);
    List<dynamic> realData = jsonData['real_data'];
    List<dynamic> calcData = jsonData['calc_data'];

    List<RealtimeEnergy> dataReal = [];

    for (var i = 0; i < realData.length; i++) {
      var realDataDate =
          DateFormat('HH:mm').format(DateTime.parse(realData[i]['date']));
      var realDataValue = realData[i]['value']?.toDouble() ?? 0.0;
      var realDataWindSpeed = realData[i]['wind_speed']?.toDouble() ?? 0.0;
      var realDataRpmBilah = realData[i]['rpm_bilah']?.toDouble() ?? 0.0;
      var realDataRpmGenerator =
          realData[i]['rpm_generator']?.toDouble() ?? 0.0;
      var realDataVoltDc = realData[i]['volt_dc']?.toDouble() ?? 0.0;
      var realDataVoltAc = realData[i]['volt_ac']?.toDouble() ?? 0.0;
      var realDataAmpereDc = realData[i]['ampere_dc']?.toDouble() ?? 0.0;
      var realDataAmpereAc = realData[i]['ampere_ac']?.toDouble() ?? 0.0;

      var calcDataDate =
          DateFormat('HH:mm').format(DateTime.parse(calcData[i]['date']));
      var calcDataValue = calcData[i]['value']?.toDouble() ?? 0.0;

      dataReal.add(RealtimeEnergy(
        realDataDate,
        realDataValue,
        0,
        0,
        realDataWindSpeed,
        realDataRpmBilah,
        realDataRpmGenerator,
        realDataVoltDc,
        realDataAmpereAc,
        realDataAmpereDc,
        realDataVoltAc,
        0,
        0,
        calcDataDate,
        calcDataValue,
      ));
    }

    if (mounted) {
      setState(() {
        _dataReal = dataReal;
        // _dataReal.clear();
        // for (var dataReal in jsonData) {
        // _dataReal.add(
        //   RealtimeEnergy(
        //     dataReal['date'] != null
        //         ? DateFormat('HH:mm')
        //             .format(DateTime.parse(dataReal['date']))
        //         : '',
        //     (dataReal['real_data']['value'] ?? 0.0),
        //     0,
        //     dataReal['wind_speed']?.toDouble() ?? 0.0,
        //     dataReal['real_data']['rpm_bilah'],
        //     dataReal['real_data']['rpm_generator'],
        //     dataReal['real_data']['volt_dc']?.toDouble() ?? 0.0,
        //     dataReal['real_data']['volt_ac']?.toDouble() ?? 0.0,
        //     dataReal['real_data']['ampere_dc']?.toDouble() ?? 0.0,
        //     dataReal['real_data']['ampere_ac']?.toDouble() ?? 0.0,
        //     0,
        //   ),
        // );

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
        //   }
      });
    }
  }

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
                series: <ChartSeries<RealtimeEnergy, dynamic>>[
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Power PLTB',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(225, 0, 74, 173),
                    xValueMapper: (RealtimeEnergy data, _) => data.date,
                    yValueMapper: (RealtimeEnergy data, _) => data.powerWtDc,
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
                    color: const Color.fromARGB(224, 255, 152, 34),
                    xValueMapper: (RealtimeEnergy data, _) => data.date,
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
                    name: 'Rpm Bilah',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(224, 190, 27, 223),
                    xValueMapper: (RealtimeEnergy data, _) => data.date,
                    yValueMapper: (RealtimeEnergy data, _) => data.rpmBilah,
                    // yAxisName: 'yAxis',
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 5,
                      width: 5,
                    ),
                  ),
                  SplineSeries<RealtimeEnergy, dynamic>(
                    name: 'Rpm Generator',
                    dataSource: _dataReal,
                    enableTooltip: true,
                    color: const Color.fromARGB(255, 27, 223, 102),
                    xValueMapper: (RealtimeEnergy data, _) => data.date,
                    yValueMapper: (RealtimeEnergy data, _) => data.rpmGenerator,
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
          )
        : datePicker();
  }

  Row datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
