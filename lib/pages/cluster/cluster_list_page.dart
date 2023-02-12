import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/cluster/add_cluster.dart';
import 'package:manajemen_aset/pages/cluster/edit_cluster.dart';
import 'package:manajemen_aset/service/database.dart';

class ClusterList extends StatefulWidget {
  const ClusterList({Key? key}) : super(key: key);

  @override
  State<ClusterList> createState() => _ClusterListState();
}

class _ClusterListState extends State<ClusterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: DatabaseService().listCluster(),
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
                    String cluster = documentSnapshot['nama'];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Card(
                          child: ListTile(
                            title: Text(cluster),
                            trailing: PopupMenuButton<int>(
                              iconSize: 20,
                              itemBuilder: (context) => [
                                // PopupMenuItem 1
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(width: 10),
                                      Text("Edit Cluster")
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
                                      Text("Hapus Cluster")
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 1) {
                                  // edit cluster
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditCluster(
                                        clusterId: docId,
                                        currentCluster: cluster,
                                      ),
                                    ),
                                  );
                                } else if (value == 2) {
                                  // hapus cluster
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Hapus"),
                                      content: const Text(
                                        "Apakah anda yakin untuk hapus cluster ini? ",
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Batal",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  225, 125, 122, 116),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await DatabaseService()
                                                .deleteCluster(
                                              docId: docId,
                                              nama: cluster,
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Hapus"),
                                        ),
                                      ],
                                    ),
                                  );
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
              MaterialPageRoute(builder: (context) => const AddCluster()));
        },
      ),
    );
  }
}
