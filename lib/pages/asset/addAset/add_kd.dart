import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddKd extends StatefulWidget {
  const AddKd({Key? key}) : super(key: key);

  @override
  State<AddKd> createState() => _AddKdState();
}

class _AddKdState extends State<AddKd> {
  final _addKdKey = GlobalKey<FormState>();

  // SPD Wajib
  TextEditingController spd31C = TextEditingController();

  // SPD Opsional
  TextEditingController spd32C = TextEditingController();
  TextEditingController spd33C = TextEditingController();
  TextEditingController spd34C = TextEditingController();
  TextEditingController spd35C = TextEditingController();

  TextEditingController lokasiC = TextEditingController();
  TextEditingController tglPasangC = TextEditingController();

  List allTextField = [];

  DateTime? _dateTimeP;

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

  @override
  void initState() {
    super.initState();
    lokasiC.text = "Onsite"; //default text
    allTextField = [
      {
        "value": spd32C,
        "text_field": InputForm(
          title: "SPD 3.2",
          controller: spd32C,
          prefixIcon: const Icon(Icons.description_outlined),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd33C,
        "text_field": InputForm(
          title: "SPD 3.3",
          controller: spd33C,
          prefixIcon: const Icon(Icons.description_outlined),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd34C,
        "text_field": InputForm(
          title: "SPD 3.4",
          controller: spd34C,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd35C,
        "text_field": InputForm(
          title: "SPD 3.5",
          controller: spd35C,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
    ];
  }

  List displayTextField = [];

  addTextField() {
    print("addTextField");

    setState(() {
      if (allTextField.length == displayTextField.length) {
        print("Same");
        return;
      } else {
        displayTextField.add(allTextField[displayTextField.length]);
      }
    });
  }

  removeTextField() {
    print("removeTextField");

    setState(() {
      if (displayTextField.isNotEmpty) {
        displayTextField.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SPD 3 (Komunikasi Data)")),
      body: Form(
        key: _addKdKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama
                InputForm(
                  title: "SPD 3.1*",
                  controller: spd31C,
                  prefixIcon: const Icon(Icons.description_outlined),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('SPD Tambahan :'),
                    ElevatedButton(
                      onPressed: addTextField,
                      child: const Text('Tambah'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: const Color.fromARGB(225, 12, 144, 125),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: removeTextField,
                      child: const Text('Hapus'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: const Color.fromARGB(255, 151, 158, 157),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                ...displayTextField
                    .map(
                      (e) => Column(
                        children: [
                          e['text_field'],
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    )
                    .toList(),

                // lokasi Asset
                NonEditableForm(
                  title: "Lokasi Asset*",
                  controller: lokasiC,
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Tanggal dipasang
                TextFormField(
                  autofocus: true,
                  controller: tglPasangC,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Dipasang*',
                    prefixIcon: const Icon(Icons.event_outlined),
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
                      primary: const Color.fromARGB(225, 12, 144, 125),
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
