import 'package:flutter/material.dart';

class AsetCard extends StatelessWidget {
  final String kode;
  final String namaAset;
  final String statusKonfirmasi;

  const AsetCard({
    Key? key,
    required this.kode,
    required this.statusKonfirmasi,
    required this.namaAset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      kode,
                      style: const TextStyle(
                        color: Color.fromARGB(225, 0, 74, 173),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      namaAset,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  statusKonfirmasi,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: PopupMenuButton<int>(
                  iconSize: 20,
                  itemBuilder: (context) => [
                    // PopupMenuItem 1
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.edit),
                          SizedBox(width: 10),
                          Text("Edit Cluster")
                        ],
                      ),
                    ),
                    // PopupMenuItem 2
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 10),
                          Text("Hapus Cluster")
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      // edit cluster
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditUser(
                      //       currentEmail: email,
                      //       currentNama: nama,
                      //       currentRole: role,
                      //     ),
                      //   ),
                      // );
                    } else if (value == 2) {
                      // hapus cluster
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
