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
              WtChart(idWt: widget.idPerangkat)
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
    );
  }
}
