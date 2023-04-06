import 'dart:io';

import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/service/database.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class AddSipil extends StatefulWidget {
  final String perangkatId;
  final String clusterId;
  const AddSipil({Key? key, required this.perangkatId, required this.clusterId})
      : super(key: key);

  @override
  State<AddSipil> createState() => _AddSipilState();
}

class _AddSipilState extends State<AddSipil> {
  final _addSipilKey = GlobalKey<FormState>();

  // SPD Wajib
  TextEditingController spd61C = TextEditingController();
  TextEditingController spd62C = TextEditingController();
  // SPD Opsional
  TextEditingController spd63C = TextEditingController();
  TextEditingController spd64C = TextEditingController();
  TextEditingController spd65C = TextEditingController();

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

  File? _pickedImage;
  File? _pickedImage2;

  Future openCamera() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image == null) return;
    File? img = File(image.path);
    setState(() {
      _pickedImage = img;
      // Navigator.of(context).pop();
    });
  }

  Future openCamera2() async {
    final image2 = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image2 == null) return;
    File? img2 = File(image2.path);
    setState(() {
      _pickedImage2 = img2;
      // Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    lokasiC.text = "Onsite"; //default text
    allTextField = [
      {
        "value": spd63C,
        "text_field": InputForm(
          title: "SPD 6.3",
          controller: spd63C,
          prefixIcon: const Icon(Iconsax.document_text),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd64C,
        "text_field": InputForm(
          title: "SPD 6.4",
          controller: spd64C,
          prefixIcon: const Icon(Iconsax.document_text),
          validator: (val) {
            if (val!.isEmpty) {
              return 'Wajib diisi';
            }
            return null;
          },
        ),
      },
      {
        "value": spd65C,
        "text_field": InputForm(
          title: "SPD 6.5",
          controller: spd65C,
          prefixIcon: const Icon(Iconsax.document_text),
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
      appBar: AppBar(title: const Text("SPD 6 (Sipil)")),
      body: Form(
        key: _addSipilKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // nama
                InputForm(
                  title: "SPD 6.1*",
                  controller: spd61C,
                  prefixIcon: const Icon(Iconsax.document_text),
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
                  title: "SPD 6.2*",
                  controller: spd62C,
                  prefixIcon: const Icon(Iconsax.document_text),
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
                  prefixIcon: const Icon(Iconsax.document_text),
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
                    prefixIcon: const Icon(Iconsax.calendar_1),
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

                // foto 1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Foto 1"),
                    GestureDetector(
                      onTap: () {
                        openCamera();
                      },
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.19,
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: _pickedImage == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Iconsax.camera),
                                      Text('Add Foto')
                                    ],
                                  )
                                : ClipRect(
                                    child: Image(
                                      image: FileImage(_pickedImage!),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),

                // foto 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Foto 2"),
                    GestureDetector(
                      onTap: () {
                        openCamera2();
                      },
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.19,
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: _pickedImage2 == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Iconsax.camera),
                                      Text('Add Foto')
                                    ],
                                  )
                                : ClipRect(
                                    child: Image(
                                      image: FileImage(_pickedImage2!),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),

                //submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_addSipilKey.currentState!.validate() &&
                          _pickedImage != null) {
                        await DatabaseService().addSipil(
                          id: '0',
                          spd61: spd61C.text,
                          spd62: spd62C.text,
                          spd63: spd63C.text,
                          spd64: spd64C.text,
                          spd65: spd65C.text,
                          lokasi: lokasiC.text,
                          tglPasang: tglPasangC.text,
                          img1: _pickedImage,
                          img2: _pickedImage2,
                          idPerangkat: widget.perangkatId,
                          idCluster: widget.clusterId,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Asset Berhasil Tersimpan'),
                          ),
                        );
                      } else if (_pickedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill image'),
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
