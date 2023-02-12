import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: listChip(),
            ),
          ),
          Expanded(
            child: Center(child: currentTab()),
          ),
        ],
      ),
    );
  }

  listChip() {
    return Row(
      children: _chipBarList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: ChoiceChip(
                label: Text(item.title),
                selected: idSelected == item.id,
                onSelected: (_) => setState(() => idSelected = item.id),
              ),
            ),
          )
          .toList(),
    );
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
                  String cluster = documentSnapshot['cluster'];
                  String jenisAset = documentSnapshot['jenisAset'];
                  String kodeAset = documentSnapshot['kodeAset'];
                  String kondisiAset = documentSnapshot['kondisiAset'];
                  String merekAset = documentSnapshot['merekAset'];
                  String namaAset = documentSnapshot['namaAset'];
                  String perangkat = documentSnapshot['perangkat'];
                  String statusKonfirmasi =
                      documentSnapshot['statusKonfirmasi'];
                  String tglBeroperasi = documentSnapshot['tglBeroperasi'];
                  String tglDipasang = documentSnapshot['tglDipasang'];

                  return AsetCard(
                    kode: kodeAset,
                    statusKonfirmasi: statusKonfirmasi,
                    namaAset: namaAset,
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
