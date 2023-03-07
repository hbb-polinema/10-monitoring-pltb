import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/perangkat/add_perangkat.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/chipBar.dart';
import 'package:manajemen_aset/widget/perangkat_card.dart';

class ListPerangkat extends StatefulWidget {
  const ListPerangkat({Key? key}) : super(key: key);

  @override
  State<ListPerangkat> createState() => _ListPerangkatState();
}

class _ListPerangkatState extends State<ListPerangkat> {
  var idSelected = 0;
  Widget currentTab() {
    return _chipBarList[idSelected].bodyWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 12, 144, 125),
        elevation: 0,
        title: const Text('Data Perangkat'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(225, 12, 144, 125),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPerangkat()));
        },
      ),
    );
  }

  listChip() {
    return Row(
      children: _chipBarList
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 0),
              child: ChoiceChip(
                label: Text(item.title),
                selected: idSelected == item.id,
                labelStyle: TextStyle(
                  color: idSelected == item.id ? Colors.white : Colors.black,
                ),
                selectedColor: const Color.fromARGB(225, 12, 144, 125),
                onSelected: (_) => setState(() => idSelected = item.id),
              ),
            ),
          )
          .toList(),
    );
  }
}

class BuilderPerangkat extends StatelessWidget {
  final stream;
  const BuilderPerangkat({
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
          return Expanded(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final documentSnapshot = snapshot.data!.docs[index];
                    final String docId = snapshot.data!.docs[index].id;
                    String kode = documentSnapshot['kodePerangkat'];
                    String jenis = documentSnapshot['jenisPerangkat'];
                    String cluster = documentSnapshot['cluster'];

                    return PerangkatCard(kode: kode, cluster: cluster);
                  },
                ),
              ],
            ),
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
    BuilderPerangkat(
      stream: DatabaseService().listPerangkat(),
    ),
  ),
  ItemChipBar(
    1,
    'Wind Turbine',
    BuilderPerangkat(
      stream: DatabaseService().listPerangkatWT(),
    ),
  ),
  ItemChipBar(
    2,
    'Solar Panel',
    BuilderPerangkat(
      stream: DatabaseService().listPerangkatSP(),
    ),
  ),
  ItemChipBar(
    3,
    'Diesel',
    BuilderPerangkat(
      stream: DatabaseService().listPerangkatDS(),
    ),
  ),
  ItemChipBar(
    4,
    'Batery',
    BuilderPerangkat(
      stream: DatabaseService().listPerangkatBT(),
    ),
  ),
  ItemChipBar(
    5,
    'Weather Station',
    BuilderPerangkat(
      stream: DatabaseService().listPerangkatWS(),
    ),
  ),
];
