import 'package:flutter/material.dart';

class DetailAsset extends StatefulWidget {
  // final String documentId;
  // final String kodeAset;
  // final String namaAset;
  // final String namaPetugas;
  // final String tanggal;
  // final String status;
  const DetailAsset({
    Key? key,
    // required this.documentId,
    // required this.kodeAset,
    // required this.namaAset,
    // required this.namaPetugas,
    // required this.tanggal,
    // required this.status,
  }) : super(key: key);

  @override
  State<DetailAsset> createState() => _DetailAssetState();
}

class _DetailAssetState extends State<DetailAsset> {
  String statusKonfirmasi = 'Menunggu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Aset"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // Container(
                //   margin: const EdgeInsets.only(
                //     bottom: 30,
                //     top: 8,
                //   ),
                //   // height: MediaQuery.of(context).size.height * 0.32,
                //   // width: MediaQuery.of(context).size.width * 0.45,
                //   child: Stack(
                //     children: [
                //       Container(
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           boxShadow: <BoxShadow>[
                //             BoxShadow(
                //               color: Colors.black.withOpacity(0.2),
                //               blurRadius: 29,
                //               offset: const Offset(8, 8),
                //               spreadRadius: 3,
                //             ),
                //             BoxShadow(
                //               color: Colors.black.withOpacity(0.2),
                //               blurRadius: 25,
                //               offset: const Offset(-8, -8),
                //               // spreadRadius: 3,
                //             )
                //           ],
                //         ),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(20),
                //           child: Image(
                //             image: AssetImage('img/no-image.png'),
                //             // image: NetworkImage(
                //             //   widget.urlCoverBook,
                //             // ),
                //             fit: BoxFit.fill,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // nama Aset
                SizedBox(
                  child: Text(
                    "Nama Aset",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // kode aset
                SizedBox(
                  child: Text(
                    "Kode Aset",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(225, 0, 74, 173),
                    ),
                  ),
                ),

                // status konfirmasi
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Status Konfirmasi',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Menunggu Konfirmasi',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // lokasi aset
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Lokasi Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Detail lokasi',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Jenis Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Jenis aset',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // merek
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Merek Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Merek Aset',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // tanggal dipasang
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Tanggal Dipasang',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '02 Feb 2022',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // tanggal beroperasi
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Tanggal Mulai Beroperasi',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '03 Feb 2022',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // umur aset
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Umur Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '5 Tahun',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // kondisi aset
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Kondisi Aset',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
