import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/asset_list_page.dart';
import 'package:manajemen_aset/pages/monitoring/monitoring_ws_screen.dart';
import 'package:manajemen_aset/service/database.dart';

class ListP extends StatefulWidget {
  const ListP({Key? key}) : super(key: key);

  @override
  State<ListP> createState() => _ListPState();
}

class _ListPState extends State<ListP> with SingleTickerProviderStateMixin {
  // ScrollController? _scrollController;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(225, 12, 144, 125),
          elevation: 0,
          title: const Text('Data Asset'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // Tab Bar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                unselectedLabelColor: Colors.black54,
                labelColor: const Color.fromARGB(225, 12, 144, 125),
                labelPadding: const EdgeInsets.only(right: 10, left: 10),
                tabs: const [
                  Tab(
                    child: Text(
                      'Asset',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Monitoring',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Report',
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
                  children: [
                    BuilderAset(stream: DatabaseService().listAset()),
                    MonitoringWsScreen(),
                    MonitoringWsScreen(),
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
