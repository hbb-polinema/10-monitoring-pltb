import 'package:flutter/material.dart';
import 'package:manajemen_aset/monitoring/selected_chart.dart';

class SelectedDateScreen extends StatefulWidget {
  const SelectedDateScreen({Key? key}) : super(key: key);

  @override
  State<SelectedDateScreen> createState() => _SelectedDateScreenState();
}

class _SelectedDateScreenState extends State<SelectedDateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 15),
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
                    SelectedDateChart(),
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
