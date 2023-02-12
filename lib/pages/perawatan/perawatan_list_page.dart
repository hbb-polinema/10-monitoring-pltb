import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/chipBar.dart';
import 'package:manajemen_aset/widget/history_card.dart';

class ListPerawatan extends StatefulWidget {
  const ListPerawatan({Key? key}) : super(key: key);

  @override
  State<ListPerawatan> createState() => _ListPerawatanState();
}

class _ListPerawatanState extends State<ListPerawatan> {
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

class BuilderPerawatan extends StatelessWidget {
  final stream;
  const BuilderPerawatan({
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
                  String kodeAset = documentSnapshot['kodeAset'];
                  String namaAset = documentSnapshot['namaAset'];
                  String cluster = documentSnapshot['cluster'];
                  String namaPetugas = documentSnapshot['petugas'];
                  String tglPerawatan = documentSnapshot['tglPerawatan'];
                  String status = documentSnapshot['statusKonfirmasi'];

                  return HistoryCard(
                    kodeAset: kodeAset,
                    namaAset: namaAset,
                    cluster: cluster,
                    namaPetugas: namaPetugas,
                    tanggal: tglPerawatan,
                    status: status,
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
    BuilderPerawatan(
      stream: DatabaseService().listPerawatan(),
    ),
  ),
  ItemChipBar(
    1,
    'Belum Dikonfirmasi',
    BuilderPerawatan(
      stream: DatabaseService().listPerawatan(),
    ),
  ),
  ItemChipBar(2, 'Diterima', Text('Tab 3')),
  ItemChipBar(3, 'Ditolak', Text('Tab 4')),
];
