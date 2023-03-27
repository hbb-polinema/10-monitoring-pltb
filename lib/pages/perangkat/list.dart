import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/asset.dart';
import 'package:manajemen_aset/pages/monitoring/monitoring_screen.dart';

class ListP extends StatefulWidget {
  final String docClusterId;
  final String docPerangkatId;
  final String perangkatId;
  final String jenisPerangkat;
  const ListP({
    Key? key,
    required this.docClusterId,
    required this.docPerangkatId,
    required this.perangkatId,
    required this.jenisPerangkat,
  }) : super(key: key);

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
        body: ListView(
          children: [
            // Tab Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: TabBar(
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
            ),

            // Tab View
            SizedBox(
              width: double.infinity,
              height: 600,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // list aset
                  // BuilderAset(
                  //   stream: DatabaseService().listAset(
                  //     widget.docClusterId,
                  //     widget.docPerangkatId,
                  //   ),
                  // ),
                  ExpansionTileCardDemo(
                    idCluster: widget.docClusterId,
                    idPerangkat: widget.docPerangkatId,
                  ),
                  // pindah ke halaman untuk cek jenis aset
                  MonitoringScreen(
                    jenisPerangkat: widget.jenisPerangkat,
                    idPerangkat: widget.perangkatId,
                  ),
                  // halaman report
                  MonitoringScreen(
                    jenisPerangkat: widget.jenisPerangkat,
                    idPerangkat: widget.perangkatId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
