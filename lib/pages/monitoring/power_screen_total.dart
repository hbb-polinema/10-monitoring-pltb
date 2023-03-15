import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/power_chart_total.dart';

class PowerScreenTotal extends StatefulWidget {
  final String idCluster;
  const PowerScreenTotal({Key? key, required this.idCluster})
      : super(key: key);

  @override
  State<PowerScreenTotal> createState() => _PowerScreenTotalState();
}

class _PowerScreenTotalState extends State<PowerScreenTotal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 12, 144, 125),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Produksi Realtime Energy Listrik (EBT)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        PowerChartTotal(
                          idCluster: widget.idCluster,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
