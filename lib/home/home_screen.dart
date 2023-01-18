import 'package:flutter/material.dart';

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

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.dateTime = dateTime;
    });
  }

  // void _showTimePicker() {
  //   showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute),
  //     // firstDate: DateTime(2000),
  //     // lastDate: DateTime(2050),
  //   ).then((value) {
  //     setState(() {
  //       dateTime = value!;
  //     });
  //   });
  // }

  // Future PickDateTime() async {
  //   _showDatePicker();
  //   _showTimePicker();
  // }

  @override
  Widget build(BuildContext context) {
    // final hours = dateTime!.hour.toString().padLeft(2, '0');
    // final minutes = dateTime!.minute.toString().padLeft(2, '0');

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 15),
                      child: Container(
                        width: double.infinity,
                        height: 600,
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  // //date
                                  // Row(
                                  //   children: [
                                  //     const Icon(Icons.calendar_month_rounded),
                                  //     Text(dateTime == null
                                  //         ? DateFormat('dd MM yyyy HH:mm:ss')
                                  //             .format(DateTime.now())
                                  //         : DateFormat('dd MMM yyyy HH:mm:00')
                                  //             .format(dateTime!)),
                                  //     IconButton(
                                  //       onPressed: () async {
                                  //         pickDateTime();
                                  //       },
                                  //       icon: const Icon(Icons.expand_more),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(
                                height: 8,
                              ),
                              // const Chart2(),
                              // RealtimeChart()
                              // const NewChart(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // const Text(
                    //   'Dashboard',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Expanded(
                    //   child: GridView.count(
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 24,
                    //     mainAxisSpacing: 24,
                    //     children: const [
                    //       StatusCard(
                    //           img: 'img/turbine.png',
                    //           title: '4',
                    //           subTitle: 'Wind Turbine'),
                    //       StatusCard(
                    //           img: 'img/partly-cloudy.png',
                    //           title: '4',
                    //           subTitle: 'Weather Station'),
                    //       StatusCard(
                    //           img: 'img/solar-panel.png',
                    //           title: '4',
                    //           subTitle: 'Solar Panel'),
                    //       StatusCard(
                    //           img: 'img/battery-charge.png',
                    //           title: '4',
                    //           subTitle: 'TBattery'),
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 20,
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
