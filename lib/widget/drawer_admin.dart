import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/home/home_screen.dart';
import 'package:manajemen_aset/user/user_list_page.dart';
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
      container = const ListUser();
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
          menuItem(2, "Users", Icons.people,
              currentPage == DrawerSectionsAdmin.users ? true : false),
          menuItem(3, "Logout", Icons.logout,
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

enum DrawerSectionsAdmin {
  home,
  users,
  logout,
}

Future<void> _logOut() async {
  await FirebaseAuth.instance.signOut();
}
