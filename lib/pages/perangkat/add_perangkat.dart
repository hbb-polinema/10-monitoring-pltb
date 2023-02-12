import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddPerangkat extends StatefulWidget {
  const AddPerangkat({Key? key}) : super(key: key);

  @override
  State<AddPerangkat> createState() => _AddPerangkatState();
}

class _AddPerangkatState extends State<AddPerangkat> {
  final _addPerangkatKey = GlobalKey<FormState>();

  // text field controller
  final TextEditingController kodeC = TextEditingController();

  final jenisList = [
    'Wind Turbine',
    'Solar Panel',
    'Diesel',
    'Batery',
    'Weather Station',
  ];
  String? selectedJenis = '';
  var selectedCluster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Perangkat")),
      body: Form(
        key: _addPerangkatKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // cluster
                StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService().listCluster(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      const Text("Loading.....");
                    } else {
                      List<DropdownMenuItem> clusterName = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        var cluster = snap['nama'];
                        clusterName.add(
                          DropdownMenuItem(
                            child: Text(
                              cluster,
                            ),
                            value: cluster,
                          ),
                        );
                      }
                      return DropdownButtonFormField<dynamic>(
                        items: clusterName,
                        onChanged: (val) {
                          setState(() {
                            selectedCluster = val as String;
                          });
                        },
                        value: selectedCluster,
                        decoration: InputDecoration(
                          labelText: 'Cluster',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Pilih Cluster';
                          }
                          return null;
                        },
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
                const SizedBox(
                  height: 16,
                ),

                // jenis
                DropdownButtonFormField(
                  items: jenisList
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedJenis = val as String;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Jenis Perangkat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih Perangkat';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // Kode
                InputForm(
                  title: "Kode",
                  controller: kodeC,
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
                      if (_addPerangkatKey.currentState!.validate()) {
                        await DatabaseService().addPerangkat(
                          kodePerangkat: kodeC.text,
                          jenisPerangkat: selectedJenis,
                          cluster: selectedCluster,
                        );

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Data Perangkat Berhasil ditambahkan'),
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
