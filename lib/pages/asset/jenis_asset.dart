import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_elektrik.dart';
import 'package:manajemen_aset/pages/asset/addAset/add_jaringan.dart';

class JenisAsset extends StatefulWidget {
  const JenisAsset({Key? key}) : super(key: key);

  @override
  State<JenisAsset> createState() => _JenisAssetState();
}

class _JenisAssetState extends State<JenisAsset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jenis Asset")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text(
                  'Elektrikal',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: const Text('Deskripsi'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddElektrik(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text(
                  'Jaringan',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: const Text('Deskripsi'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddJaringan(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
             Card(
              child: ListTile(
                title: const Text(
                  'Mekanik',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text('Deskripsi'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddJaringan(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                title: Text(
                  'Sensor',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Text('Deskripsi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
