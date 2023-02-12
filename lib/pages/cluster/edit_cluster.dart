import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class EditCluster extends StatefulWidget {
  final clusterId;
  final String currentCluster;
  const EditCluster({Key? key, this.clusterId, required this.currentCluster})
      : super(key: key);

  @override
  State<EditCluster> createState() => _EditClusterState();
}

class _EditClusterState extends State<EditCluster> {
  final _editClusterKey = GlobalKey<FormState>();

  // text field controller
  TextEditingController clusterC = TextEditingController();
  @override
  void initState() {
    clusterC = TextEditingController(text: widget.currentCluster);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
      body: Form(
        key: _editClusterKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama
                InputForm(
                  title: "Nama Cluster",
                  controller: clusterC,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Wajib diiisi';
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
                      if (_editClusterKey.currentState!.validate()) {
                        await DatabaseService().updateCluster(
                          clusterId: widget.clusterId,
                          nama: clusterC.text,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cluster Berhasil Diupdate'),
                          ),
                        );
                      } else {
                        const SnackBar(
                          content: Text('Gagal '),
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
