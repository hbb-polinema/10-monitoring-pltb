import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/asset_list_page.dart';
import 'package:manajemen_aset/pages/laporan/laporan_screen.dart';
import 'package:manajemen_aset/pages/perangkat/list.dart';

class PerangkatCard extends StatelessWidget {
  const PerangkatCard({
    Key? key,
    required this.kode,
    required this.status,
    required this.img,
  }) : super(key: key);

  final String kode;
  final String status;
  final String img;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ListP(),
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
              Image(
                image: AssetImage(img),
                width: 50,
              ),
              const SizedBox(width: 16),
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
                            color: Color.fromARGB(225, 12, 144, 125),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // icon status
                        Icon(
                          status == "Aktif"
                              ? Icons.task_alt
                              : Icons.highlight_off,
                          color: status == "Aktif" ? Colors.green : Colors.red,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      // width: 100,
                      child: Text(
                        status,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
