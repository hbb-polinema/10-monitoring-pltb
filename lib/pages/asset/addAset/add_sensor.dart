import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddSensor extends StatefulWidget {
  const AddSensor({Key? key}) : super(key: key);

  @override
  State<AddSensor> createState() => _AddSensorState();
}

class _AddSensorState extends State<AddSensor> {
  final _addSensorKey = GlobalKey<FormState>();

  // SPD Wajib
  TextEditingController spd41C = TextEditingController();
  TextEditingController spd42C = TextEditingController();
  // SPD Opsional
  TextEditingController spd43C = TextEditingController();
  TextEditingController spd44C = TextEditingController();
  TextEditingController spd45C = TextEditingController();

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
        "value": spd43C,
        "text_field": InputForm(
          title: "SPD 4.3",
          controller: spd43C,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd44C,
        "text_field": InputForm(
          title: "SPD 4.4",
          controller: spd44C,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd45C,
        "text_field": InputForm(
          title: "SPD 4.5",
          controller: spd45C,
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
      appBar: AppBar(title: const Text("SPD 5 (Sensor)")),
      body: Form(
        key: _addSensorKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama
                InputForm(
                  title: "SPD 4.1*",
                  controller: spd41C,
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

                // SPD 4.2
                InputForm(
                  title: "SPD 4.2*",
                  controller: spd42C,
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
