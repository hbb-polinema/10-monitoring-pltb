import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/asset_list_page.dart';
import 'package:manajemen_aset/pages/cluster/cluster_list_page.dart';
import 'package:manajemen_aset/pages/home/home_screen.dart';
import 'package:manajemen_aset/pages/pengecekan/pengecekan_list_page.dart';
import 'package:manajemen_aset/pages/perangkat/perangkat_list_page.dart';
import 'package:manajemen_aset/pages/perawatan/perawatan_list_page.dart';
import 'package:manajemen_aset/pages/perbaikan/perbaikan_list_page.dart';
import 'package:manajemen_aset/pages/user/user_list_page.dart';
import 'package:manajemen_aset/widget/my_header_drawer.dart';

class DrawerAdmin extends StatefulWidget {
  const DrawerAdmin({Key? key}) : super(key: key);

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  var currentPage = DrawerSectionsAdmin.home;
  var container;

  @override
  Widget build(BuildContext context) {
    container;
    if (currentPage == DrawerSectionsAdmin.home) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSectionsAdmin.users) {
      container = const UserList();
    } else if (currentPage == DrawerSectionsAdmin.cluster) {
      container = const ClusterList();
    } else if (currentPage == DrawerSectionsAdmin.perangkat) {
      container = const ListPerangkat();
    } else if (currentPage == DrawerSectionsAdmin.aset) {
      container = const AssetList();
    } else if (currentPage == DrawerSectionsAdmin.pengecekan) {
      container = const ListPengecekan();
    } else if (currentPage == DrawerSectionsAdmin.perawatan) {
      container = const ListPerawatan();
    } else if (currentPage == DrawerSectionsAdmin.perbaikan) {
      container = const ListPerbaikan();
    } else if (currentPage == DrawerSectionsAdmin.logout) {
      _logOut();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 0, 74, 173),
        elevation: 0,
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              drawerAdminListAdmin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerAdminListAdmin() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSectionsAdmin.home ? true : false),
          menuItem(2, "User", Icons.people,
              currentPage == DrawerSectionsAdmin.users ? true : false),
          menuItem(3, "Cluster", Icons.map,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
          menuItem(4, "Data Perangkat", Icons.grid_view_rounded,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
          menuItem(5, "Aset", Icons.inventory,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
          menuItem(6, "Pengecekan Aset", Icons.check_box,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
          menuItem(7, "Perawatan Aset", Icons.settings,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
          menuItem(8, "Perbaikan Aset", Icons.error,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
          menuItem(9, "Logout", Icons.exit_to_app,
              currentPage == DrawerSectionsAdmin.logout ? true : false),
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
              currentPage = DrawerSectionsAdmin.home;
            } else if (id == 2) {
              currentPage = DrawerSectionsAdmin.users;
            } else if (id == 3) {
              currentPage = DrawerSectionsAdmin.cluster;
            } else if (id == 4) {
              currentPage = DrawerSectionsAdmin.perangkat;
            } else if (id == 5) {
              currentPage = DrawerSectionsAdmin.aset;
            } else if (id == 6) {
              currentPage = DrawerSectionsAdmin.pengecekan;
            } else if (id == 7) {
              currentPage = DrawerSectionsAdmin.perawatan;
            } else if (id == 8) {
              currentPage = DrawerSectionsAdmin.perbaikan;
            } else if (id == 9) {
              currentPage = DrawerSectionsAdmin.logout;
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

enum DrawerSectionsAdmin {
  home,
  users,
  cluster,
  perangkat,
  aset,
  pengecekan,
  perawatan,
  perbaikan,
  logout,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
