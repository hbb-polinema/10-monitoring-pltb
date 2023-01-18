import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/asset/asset_screen.dart';
import 'package:manajemen_aset/home/home_screen.dart';
import 'package:manajemen_aset/laporan/laporan_screen.dart';
import 'package:manajemen_aset/location/location_screen.dart';
import 'package:manajemen_aset/monitoring/monitoring_energy.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentPage = DrawerSections.home;
  var container;

  @override
  Widget build(BuildContext context) {
    container;
    if (currentPage == DrawerSections.home) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSections.asset) {
      container = const AssetScreen();
    } else if (currentPage == DrawerSections.location) {
      container = const LocationScreen();
    } else if (currentPage == DrawerSections.laporan) {
      container = const LaporanScreen();
    } else if (currentPage == DrawerSections.monitoring) {
      container = const MonitoringEnergy();
    } else if (currentPage == DrawerSections.logout) {
      _logOut();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        // title: Text("Rapid Tech"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Asset", Icons.inventory,
              currentPage == DrawerSections.asset ? true : false),
          menuItem(3, "Location", Icons.map,
              currentPage == DrawerSections.location ? true : false),
          menuItem(4, "Laporan", Icons.description,
              currentPage == DrawerSections.laporan ? true : false),
          menuItem(
              5,
              "Monitoring Produksi Ennergi",
              Icons.stacked_line_chart_outlined,
              currentPage == DrawerSections.monitoring ? true : false),
          const Divider(),
          menuItem(6, "Logout", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.asset;
            } else if (id == 3) {
              currentPage = DrawerSections.location;
            } else if (id == 4) {
              currentPage = DrawerSections.laporan;
            } else if (id == 5) {
              currentPage = DrawerSections.monitoring;
            } else if (id == 6) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
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

enum DrawerSections {
  home,
  asset,
  location,
  laporan,
  monitoring,
  logout,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
