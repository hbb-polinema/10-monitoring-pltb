import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/chart.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({Key? key}) : super(key: key);

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(10, 16),
                    blurRadius: 15,
                    spreadRadius: -20,
                  )
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text(
                      'Produksi Realtime \nkW Electrical Energy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Chart(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
