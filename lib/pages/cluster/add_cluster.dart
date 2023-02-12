import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddCluster extends StatefulWidget {
  const AddCluster({Key? key}) : super(key: key);

  @override
  State<AddCluster> createState() => _AddClusterState();
}

class _AddClusterState extends State<AddCluster> {
  final _addClusterKey = GlobalKey<FormState>();

  // text field controller
  TextEditingController clusterC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Cluster")),
      body: Form(
        key: _addClusterKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama Cluster
                InputForm(
                  title: "Nama Cluster",
                  controller: clusterC,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                //submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_addClusterKey.currentState!.validate()) {
                        await DatabaseService().addCluster(nama: clusterC.text);

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data Cluster Berhasil ditambahkan'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: const Color.fromARGB(225, 0, 74, 173),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
