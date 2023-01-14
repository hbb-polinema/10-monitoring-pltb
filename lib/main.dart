import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/auth_service.dart';
import 'package:manajemen_aset/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  // late List<MonitoringData> _chartData;
  // late TooltipBehavior _tooltipBehavior;
  // late ZoomPanBehavior _zoomPanBehavior;
  // late List data;
  // HttpService service;

  // @override
  // void initState() {
  //   // _chartData = getChartData();
  //   _tooltipBehavior = TooltipBehavior(enable: true);
  //   _zoomPanBehavior = ZoomPanBehavior(
  //     enablePinching: true,
  //     enableDoubleTapZooming: true,
  //     enablePanning: true,
  //     zoomMode: ZoomMode.xy,
  //   );
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: Container(

  //       ),
        // body: SfCartesianChart(
        //   title: ChartTitle(text: 'Yearly sales analysis'),
        //   legend: Legend(isVisible: true),
        //   tooltipBehavior: _tooltipBehavior,
        //   zoomPanBehavior: _zoomPanBehavior,
        //   series: <ChartSeries>[
        //     StackedLineSeries<MonitoringData, DateTime>(
        //       name: 'Perhitungan',
        //       dataSource: _chartData,
        //       xValueMapper: (MonitoringData data, _) => data.date,
        //       yValueMapper: (MonitoringData data, _) => data.calcData,
        //       markerSettings: const MarkerSettings(isVisible: true),
        //     ),
        //     StackedLineSeries<MonitoringData, DateTime>(
        //       name: 'Pengukuran',
        //       dataSource: _chartData,
        //       xValueMapper: (MonitoringData data, _) => data.date,
        //       yValueMapper: (MonitoringData data, _) => data.realData,
        //       markerSettings: const MarkerSettings(isVisible: true),
        //     ),
        //   ],
        //   primaryXAxis: DateTimeCategoryAxis(
        //     dateFormat: DateFormat.Hms(),
        //   ),
        // ),
  //     ),
  //   );
  // }

  // List<MonitoringData> getChartData() {
  //   final List<MonitoringData> chartData = [
  //     MonitoringData(DateTime(2023, 01, 01, 14, 00, 00), 400, 200),
  //     MonitoringData(DateTime(2023, 01, 01, 14, 00, 05), 432, 210),
  //     MonitoringData(DateTime(2023, 01, 01, 14, 00, 10), 460, 290),
  //     MonitoringData(DateTime(2023, 01, 01, 14, 00, 15), 500, 260),
  //     MonitoringData(DateTime(2023, 01, 01, 14, 00, 20), 490, 230),
  //   ];
  //   return chartData;
  // }
// }

// class MonitoringData {
//   MonitoringData(this.date, this.realData, this.calcData);
//   final DateTime date;
//   final double realData;
//   final double calcData;
// }
