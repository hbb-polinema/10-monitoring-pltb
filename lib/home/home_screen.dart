import 'package:flutter/material.dart';
import 'package:manajemen_aset/widget/chart.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_aset/widget/chart2.dart';
import 'package:manajemen_aset/widget/status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? dateTime;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // body: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   child: Column(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: const Icon(Icons.reorder),
              //     ),
              //     IconButton(
              //       onPressed: () {},
              //       icon: const Icon(Icons.notifications),
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 15),
                child: Container(
                  width: double.infinity,
                  height: 450,
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
                          'Produksi Realtime \nkW Electrical Energy',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // location
                            Row(
                              children: [
                                const Icon(Icons.place),
                                const Text('Location'),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.expand_more),
                                ),
                              ],
                            ),
                            //date
                            Row(
                              children: [
                                const Icon(Icons.calendar_month_rounded),
                                Text(dateTime == null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now())
                                    : DateFormat('dd MMM yyyy')
                                        .format(dateTime!)),
                                IconButton(
                                  onPressed: () {
                                    _showDatePicker();
                                  },
                                  icon: const Icon(Icons.expand_more),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(thickness: 1),
                        const SizedBox(
                          height: 8,
                        ),
                        const Chart2(),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  children: const [
                    StatusCard(
                        img: 'img/turbine.png',
                        title: '4',
                        subTitle: 'Wind Turbine'),
                    StatusCard(
                        img: 'img/partly-cloudy.png',
                        title: '4',
                        subTitle: 'Weather Station'),
                    StatusCard(
                        img: 'img/solar-panel.png',
                        title: '4',
                        subTitle: 'Solar Panel'),
                    StatusCard(
                        img: 'img/battery-charge.png',
                        title: '4',
                        subTitle: 'TBattery'),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
