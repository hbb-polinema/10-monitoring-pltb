import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddAset extends StatefulWidget {
  const AddAset({Key? key}) : super(key: key);

  @override
  State<AddAset> createState() => _AddAsetState();
}

class _AddAsetState extends State<AddAset> {
  final _addAsetKey = GlobalKey<FormState>();
  final namaC = TextEditingController();
  final merekC = TextEditingController();
  final jenisC = TextEditingController();
  final lokasiC = TextEditingController();
  final panjangC = TextEditingController();
  final lebarC = TextEditingController();
  final tinggiC = TextEditingController();
  final beratC = TextEditingController();
  final warnaC = TextEditingController();
  final umurC = TextEditingController();
  final tglPasangC = TextEditingController();
  final tglOperasiC = TextEditingController();
  final kondisiAsetList = [
    'Ok',
    'Perlu Pengecekan',
    'Perlu Perbaikan',
    'Sedang Diperbaiki',
    'Rusak'
  ];
  String? selectedValKondisi = '';
  final statusAsetList = ['Aktif', 'Non-Aktif'];
  String? selectedValStatus = '';

  DateTime? _dateTimeP;
  DateTime? _dateTimeO;

  void _showDatePickerP() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTimeP = value!;
        tglPasangC.text = DateFormat('dd MMM yyyy').format(_dateTimeP!);
      });
    });
  }

  void _showDatePickerO() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTimeO = value!;
        tglOperasiC.text = DateFormat('dd MMM yyyy').format(_dateTimeO!);
      });
    });
  }

  @override
  void initState() {
    jenisC.text = "Elektrikal"; //default text
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Asset")),
      body: Form(
        key: _addAsetKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama Asset
                InputForm(
                  title: "Nama Asset",
                  controller: namaC,
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

                // nama merek
                InputForm(
                  title: "Merek",
                  controller: merekC,
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

                // jenis Asset
                NonEditableForm(
                  title: "Jenis Asset",
                  controller: jenisC,
                ),
                const SizedBox(
                  height: 16,
                ),

                // lokasi Asset
                InputForm(
                  title: "Lokasi Asset",
                  controller: lokasiC,
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

                // Dimensi Asset
                InputNumberForm(
                  title: "Panjang Asset",
                  controller: panjangC,
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

                // lebar Asset
                InputNumberForm(
                  title: "Lebar Asset",
                  controller: lebarC,
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

                // tinggi Asset
                InputNumberForm(
                  title: "Tinggi Asset",
                  controller: tinggiC,
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

                // berat Asset
                InputNumberForm(
                  title: "Berat Asset",
                  controller: beratC,
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

                // kondisi Asset (dropdown)
                DropdownButtonFormField(
                  items: kondisiAsetList
                      .map(
                        (e) => DropdownMenuItem(child: Text(e), value: e),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedValKondisi = val as String;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Kondisi Aset',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // status Asset (dropdown)
                DropdownButtonFormField(
                  items: statusAsetList
                      .map(
                        (e) => DropdownMenuItem(child: Text(e), value: e),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedValStatus = val as String;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Status Perangkat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // Tanggal dipasang
                TextFormField(
                  autofocus: true,
                  controller: tglPasangC,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Dipasang',
                    suffixIcon: const Icon(Icons.event),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Pilih Tanggal',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib Diisi';
                    }
                    return null;
                  },
                  onTap: () {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());
                    _showDatePickerP();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // tanggal mulai beroperasi
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  autofocus: true,
                  controller: tglOperasiC,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Mulai Beroperasi',
                    suffixIcon: const Icon(Icons.event),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Choose Date',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this section';
                    }
                    return null;
                  },
                  onTap: () {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());
                    _showDatePickerO();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                // umur Asset
                InputNumberForm(
                  title: "Umur Asset",
                  controller: umurC,
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
                      // if (_addAssetKey.currentState!.validate()) {
                      //   await DatabaseService().addCluster(nama: clusterC.text);

                      //   Navigator.pop(context);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Data Cluster Berhasil ditambahkan'),
                      //     ),
                      //   );
                      // }
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
