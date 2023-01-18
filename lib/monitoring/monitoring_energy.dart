import 'package:flutter/material.dart';
import 'package:manajemen_aset/monitoring/selected_date_screen.dart';
import 'package:manajemen_aset/monitoring/today_screen.dart';

class MonitoringEnergy extends StatefulWidget {
  const MonitoringEnergy({Key? key}) : super(key: key);

  @override
  State<MonitoringEnergy> createState() => _MonitoringEnergyState();
}

class _MonitoringEnergyState extends State<MonitoringEnergy>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                // Tab Bar
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.black54,
                  labelColor: const Color.fromARGB(225, 0, 74, 173),
                  labelPadding: const EdgeInsets.only(right: 10, left: 10),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Today',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Selected Date',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                // Tab View
                SizedBox(
                  width: double.infinity,
                  height: 600,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [TodayScreen(), SelectedDateScreen()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
