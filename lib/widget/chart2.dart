import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart2 extends StatefulWidget {
  const Chart2({Key? key}) : super(key: key);

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
late List<MonitoringData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SfCartesianChart(
        // title: ChartTitle(text: 'Yearly sales analysis'),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: _tooltipBehavior,
        zoomPanBehavior: _zoomPanBehavior,
        series: <ChartSeries>[
          StackedLineSeries<MonitoringData, String>(
            name: 'Perhitungan',
            dataSource: _chartData,
            xValueMapper: (MonitoringData data, _) => data.time,
            yValueMapper: (MonitoringData data, _) => data.calcData,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
          StackedLineSeries<MonitoringData, String>(
            name: 'Pengukuran',
            dataSource: _chartData,
            xValueMapper: (MonitoringData data, _) => data.time,
            yValueMapper: (MonitoringData data, _) => data.realData,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
        primaryXAxis: CategoryAxis(),

    );
  }

  List<MonitoringData> getChartData() {
    final List<MonitoringData> chartData = [
      MonitoringData('12:00', 400, 200),
      MonitoringData('12:05', 432, 210),
      MonitoringData('12:10', 460, 290),
      MonitoringData('12:15', 500, 260),
      MonitoringData('12:20', 490, 230),
    ];
    return chartData;
  }
}

class MonitoringData {
  MonitoringData(this.time, this.realData, this.calcData);
  final String time;
  final double realData;
  final double calcData;
}