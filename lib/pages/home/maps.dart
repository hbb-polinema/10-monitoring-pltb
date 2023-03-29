import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:manajemen_aset/models/prod_energi.dart';
import 'package:manajemen_aset/pages/monitoring/power_total/power_screen_total.dart';
import 'package:manajemen_aset/pages/monitoring/produksi_energi_screen.dart';
import 'package:manajemen_aset/pages/perangkat/perangkat_list_page.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  final docClusterId;
  const Maps({Key? key, this.docClusterId}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> with TickerProviderStateMixin {
  var currentLocation = LatLng(-0.789275, 113.921327);
  List<Marker> markers = [];

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    getMarkers();
  }

  // get data cluster
  Future<void> getMarkers() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('cluster').get();
    snapshot.docs.forEach((doc) {
      String documentId = doc.id;
      String idCluster = doc['id'];
      String namaCluster = doc['nama'];
      GeoPoint geoPoint = doc['lokasi'];
      double lat = geoPoint.latitude;
      double lng = geoPoint.longitude;
      setState(() {
        markers.add(
          Marker(
            height: 40,
            width: 40,
            point: LatLng(lat, lng),
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.wind_power,
                color: Colors.indigo,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: BottomSheetMap(
                        namaCluster: namaCluster,
                        idCluster: idCluster,
                        documentId: documentId,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              center: currentLocation,
              zoom: 4.4,
              // disable rotation
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            layers: [
              TileLayerOptions(
                minZoom: 1,
                maxZoom: 18,
                backgroundColor: Colors.black,
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: markers,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetMap extends StatefulWidget {
  const BottomSheetMap({
    Key? key,
    required this.namaCluster,
    required this.idCluster,
    required this.documentId,
  }) : super(key: key);

  final String namaCluster;
  final String idCluster;
  final String documentId;

  @override
  State<BottomSheetMap> createState() => _BottomSheetMapState();
}

class _BottomSheetMapState extends State<BottomSheetMap> {
  late Future<DataModel> fetchFuture;
  @override
  void initState() {
    super.initState();
    // fetchFuture = fetchData();
  }

  // Future<DataModel> fetchData() async {
  //   Uri url = Uri.parse("https://ebt-polinema.id/api/power-production/daily");
  //   var response = await http.post(
  //     url,
  //     body: {"date_day": DateFormat('yyyy-MM-dd').format(DateTime.now())},
  //   );
  //   if (response.statusCode == 200) {
  //     return DataModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // nama cluster
            Text(
              widget.namaCluster,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              thickness: 2,
              color: Colors.black45,
            ),

            // produksi energi (load)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Produksi Energi (kWh)",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // bar chart produksi energi
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProduksiEnergiScreen(
                          idCluster: widget.idCluster,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bar_chart),
                )
              ],
            ),
            Row(
              children: [
                // Icon(Icons.calendar_month),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 16),
            // FutureBuilder<DataModel>(
            //   future: fetchData(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else {
            //       if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       } else {
            //         return GridView.builder(
            //           gridDelegate:
            //               const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 3,
            //             childAspectRatio: 1,
            //             mainAxisSpacing: 8,
            //             crossAxisSpacing: 8,
            //           ),
            //           physics: const NeverScrollableScrollPhysics(),
            //           // scrollDirection: Axis.horizontal,
            //           shrinkWrap: true,
            //           itemCount: snapshot.data?.khwProd?.length,
            //           itemBuilder: (context, index) {
            //             final snap = snapshot.data?.khwProd?[index];
            //             String name = snap?.name ?? "";
            //             double kwhDc = snap?.kwhDc ?? 0.0;
            //             return SingleChildScrollView(
            //               physics: const NeverScrollableScrollPhysics(),
            //               child: Column(
            //                 children: [
            //                   Image.asset(
            //                     snap?.getImageAsset() ?? "",
            //                     width: 40,
            //                   ),
            //                   const SizedBox(height: 8),
            //                   Text(
            //                     name,
            //                     style: const TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 8),
            //                   Text(
            //                     kwhDc.toString(),
            //                     style: const TextStyle(
            //                       fontSize: 24,
            //                       fontWeight: FontWeight.w600,
            //                       color: Color.fromARGB(225, 12, 144, 125),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //         );
            //       }
            //     }
            //   },
            // ),
            // const SizedBox(height: 16),
            // const Divider(
            //   thickness: 2,
            //   color: Colors.black45,
            // ),

            // chart realtime monitoring produksi energi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text(
                      'Realtime Monitoring',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PowerScreenTotal(
                          idCluster: widget.idCluster,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.stacked_line_chart,
                  ),
                )
              ],
            ),
            // tombol detail
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Detail',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPerangkat(
                        docClusterId: widget.documentId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: const Color.fromARGB(225, 12, 144, 125),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
