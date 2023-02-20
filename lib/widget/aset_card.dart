import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/detail_asset.dart';

class AsetCard extends StatelessWidget {
  final String kode;
  final String namaAset;
  final String cluster;
  final String statusKonfirmasi;

  const AsetCard({
    Key? key,
    required this.kode,
    required this.statusKonfirmasi,
    required this.namaAset,
    required this.cluster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DetailAsset(
                // docID: docID,
                // product: product,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: const Color(0xff000000).withOpacity(0.06),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // kode aset
                        Text(
                          kode,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(225, 0, 74, 173),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // nama aset
                        Text(
                          namaAset,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        // cluster
                        Text(
                          cluster,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      // width: 100,
                      child: Text(
                        statusKonfirmasi,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
