import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/ws_chart.dart';
import 'package:manajemen_aset/pages/monitoring/wt_chart.dart';

class MonitoringScreen extends StatefulWidget {
  final String idPerangkat;
  final String jenisPerangkat;
  const MonitoringScreen({
    Key? key,
    required this.jenisPerangkat,
    required this.idPerangkat,
  }) : super(key: key);

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    String jenisPerangkat = widget.jenisPerangkat;
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
                  children: [
                    Text(
                      jenisPerangkat,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (jenisPerangkat == 'PLTB')
                      WtChart(idWs: widget.idPerangkat)
                    else if (jenisPerangkat == 'PLTS')
                      WsChart(idWs: widget.idPerangkat)
                    else if (jenisPerangkat == 'Diesel')
                      WsChart(idWs: widget.idPerangkat)
                    else if (jenisPerangkat == 'Batery')
                      WsChart(idWs: widget.idPerangkat)
                    else if (jenisPerangkat == 'Weather Station')
                      WsChart(idWs: widget.idPerangkat)
                    else if (jenisPerangkat == 'Rumah Energi')
                      WsChart(idWs: widget.idPerangkat),
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
