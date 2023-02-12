import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/user/add_user.dart';
import 'package:manajemen_aset/pages/user/edit_user.dart';
import 'package:manajemen_aset/service/database.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: DatabaseService().listUser(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: "Cari...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final documentSnapshot = snapshot.data!.docs[index];
                    final String docId = snapshot.data!.docs[index].id;
                    String nama = documentSnapshot['nama'];
                    String email = documentSnapshot['email'];
                    String role = documentSnapshot['role'];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Card(
                          child: ListTile(
                            title: Text(nama),
                            subtitle: Text(email),
                            trailing: PopupMenuButton<int>(
                              itemBuilder: (context) => [
                                // PopupMenuItem 1
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(width: 10),
                                      Text("Edit User")
                                    ],
                                  ),
                                ),
                                // PopupMenuItem 2
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.delete),
                                      SizedBox(width: 10),
                                      Text("Hapus User")
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 1) {
                                  // edit user
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditUser(
                                        currentEmail: email,
                                        currentNama: nama,
                                        currentRole: role,
                                      ),
                                    ),
                                  );
                                } else if (value == 2) {
                                  // hapus user
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUser()));
        },
      ),
    );
  }
}
