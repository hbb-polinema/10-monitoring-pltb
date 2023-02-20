import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/asset_list_page.dart';
import 'package:manajemen_aset/pages/home/home_screen.dart';
import 'package:manajemen_aset/pages/monitoring/monitoring_screen.dart';
import 'package:manajemen_aset/pages/pengecekan/pengecekan_list_page.dart';
import 'package:manajemen_aset/pages/perawatan/perawatan_list_page.dart';
import 'package:manajemen_aset/pages/perbaikan/perbaikan_list_page.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class DrawerPetugas extends StatefulWidget {
  const DrawerPetugas({Key? key}) : super(key: key);

  @override
  State<DrawerPetugas> createState() => _DrawerPetugasState();
}

class _DrawerPetugasState extends State<DrawerPetugas> {
  var currentPage = DrawerSectionsPetugas.home;
  var container;
  var title;

  @override
  Widget build(BuildContext context) {
    title;
    container;
    if (currentPage == DrawerSectionsPetugas.home) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSectionsPetugas.aset) {
      container = const AssetList();
      title = const Text("Aset");
    } else if (currentPage == DrawerSectionsPetugas.monitoring) {
      container = const MonitoringScreen();
      title = const Text("Monitoring");
    } else if (currentPage == DrawerSectionsPetugas.pengecekan) {
      container = const ListPengecekan();
      title = const Text("History Pengecekan Aset");
    } else if (currentPage == DrawerSectionsPetugas.perawatan) {
      container = const ListPerawatan();
      title = const Text("History Perawatan Aset");
    } else if (currentPage == DrawerSectionsPetugas.perbaikan) {
      container = const ListPerbaikan();
      title = const Text("History Perbaikan Aset");
    } else if (currentPage == DrawerSectionsPetugas.logout) {
      _logOut();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 0, 74, 173),
        elevation: 0,
        title: title,
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              drawerPetugasListAdmin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerPetugasListAdmin() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSectionsPetugas.home ? true : false),
          menuItem(2, "Aset", Icons.inventory,
              currentPage == DrawerSectionsPetugas.aset ? true : false),
          menuItem(3, "Monitoring", Icons.stacked_line_chart_outlined,
              currentPage == DrawerSectionsPetugas.monitoring ? true : false),
          menuItem(4, "Pengecekan Aset", Icons.check_box,
              currentPage == DrawerSectionsPetugas.pengecekan ? true : false),
          menuItem(5, "Perawatan Aset", Icons.settings,
              currentPage == DrawerSectionsPetugas.perawatan ? true : false),
          menuItem(6, "Perbaikan Aset", Icons.error,
              currentPage == DrawerSectionsPetugas.perbaikan ? true : false),
          menuItem(7, "Logout", Icons.exit_to_app,
              currentPage == DrawerSectionsPetugas.logout ? true : false),
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
              currentPage = DrawerSectionsPetugas.home;
            } else if (id == 2) {
              currentPage = DrawerSectionsPetugas.aset;
            } else if (id == 3) {
              currentPage = DrawerSectionsPetugas.monitoring;
            } else if (id == 4) {
              currentPage = DrawerSectionsPetugas.pengecekan;
            } else if (id == 5) {
              currentPage = DrawerSectionsPetugas.perawatan;
            } else if (id == 6) {
              currentPage = DrawerSectionsPetugas.perbaikan;
            } else if (id == 7) {
              currentPage = DrawerSectionsPetugas.logout;
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
                  // size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
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

enum DrawerSectionsPetugas {
  home,
  aset,
  monitoring,
  pengecekan,
  perawatan,
  perbaikan,
  logout,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
