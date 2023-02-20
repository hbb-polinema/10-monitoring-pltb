import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_elektrik.dart';
import 'package:manajemen_aset/pages/asset/jenis_asset.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/aset_card.dart';
import 'package:manajemen_aset/widget/chipBar.dart';

class AssetList extends StatefulWidget {
  const AssetList({Key? key}) : super(key: key);

  @override
  State<AssetList> createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  var idSelected = 0;
  Widget currentTab() {
    return _chipBarList[idSelected].bodyWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(225, 0, 74, 173),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            // search
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Cari...",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular((10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          // choice chip
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: listChip(),
            ),
          ),
          // content
          Expanded(
            child: Center(child: currentTab()),
          ),
        ],
      ),
      floatingActionButton:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: DatabaseService().userRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasData) {
            String role = snapshot.data!.data()!['role'];
            // cek user untuk menampilkan tombol tambah data aset
            if (role == 'Pemilik Proyek') {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JenisAsset(),
                    ),
                  );
                },
              );
            } else {
              null;
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  listChip() {
    return Row(
      children: _chipBarList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ChoiceChip(
                label: Text(item.title),
                selected: idSelected == item.id,
                labelStyle: TextStyle(
                  color: idSelected == item.id ? Colors.white : Colors.black,
                ),
                selectedColor: const Color.fromARGB(225, 0, 74, 173),
                onSelected: (_) => setState(() => idSelected = item.id),
              ),
            ),
          )
          .toList(),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column();
        });
  }
}

class BuilderAset extends StatelessWidget {
  final stream;
  const BuilderAset({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final documentSnapshot = snapshot.data!.docs[index];
                        final String docId = snapshot.data!.docs[index].id;
                        String cluster = documentSnapshot['cluster'];
                        String jenisAset = documentSnapshot['jenisAset'];
                        String kodeAset = documentSnapshot['kodeAset'];
                        String kondisiAset = documentSnapshot['kondisiAset'];
                        String merekAset = documentSnapshot['merekAset'];
                        String namaAset = documentSnapshot['namaAset'];
                        String perangkat = documentSnapshot['perangkat'];
                        String statusKonfirmasi =
                            documentSnapshot['statusKonfirmasi'];
                        String tglBeroperasi =
                            documentSnapshot['tglBeroperasi'];
                        String tglDipasang = documentSnapshot['tglDipasang'];

                        return AsetCard(
                          kode: kodeAset,
                          cluster: cluster,
                          statusKonfirmasi: statusKonfirmasi,
                          namaAset: namaAset,
                        );
                      },
                    ),
                  ],
                ),
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
    );
  }
}

// // list untuk choice chip
final _chipBarList = <ItemChipBar>[
  ItemChipBar(
    0,
    'Semua',
    BuilderAset(
      stream: DatabaseService().listAset(),
    ),
  ),
  ItemChipBar(
    1,
    'Belum Dikonfirmasi',
    BuilderAset(
      stream: DatabaseService().listAsetMenunggu(),
    ),
  ),
  ItemChipBar(
    2,
    'Diterima',
    BuilderAset(
      stream: DatabaseService().listAsetDiterima(),
    ),
  ),
  ItemChipBar(
    3,
    'Ditolak',
    BuilderAset(
      stream: DatabaseService().listAsetDitolak(),
    ),
  ),
];
