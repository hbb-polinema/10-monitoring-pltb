import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:manajemen_aset/pages/monitoring/produksi_energi_screen.dart';
import 'package:manajemen_aset/pages/monitoring/power_screen_total.dart';
import 'package:manajemen_aset/pages/perangkat/perangkat_list_page.dart';
import 'package:intl/intl.dart';

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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
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
                                namaCluster,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          builder: (context) =>
                                              ProduksiEnergiScreen(
                                            idCluster: idCluster,
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
                                    DateFormat('dd/MM/yyyy hh:mm:ss')
                                        .format(DateTime.now()),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: const [
                                      Image(
                                        image: AssetImage('img/pltb.png'),
                                        width: 50,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'PLTB',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(225, 12, 144, 125),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Image(
                                        image: AssetImage('img/plts.png'),
                                        width: 50,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'PLTS',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(225, 12, 144, 125),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      SizedBox(height: 8),
                                      Image(
                                        image: AssetImage('img/pltd.png'),
                                        width: 50,
                                      ),
                                      Text(
                                        'Diesel',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(225, 12, 144, 125),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Image(
                                        image: AssetImage('img/energy.png'),
                                        width: 50,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(225, 12, 144, 125),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(
                                thickness: 2,
                                color: Colors.black45,
                              ),

                              // chart realtime monitoring produksi energi
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          builder: (context) =>
                                              PowerScreenTotal(
                                            idCluster: idCluster,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                width: double.infinity,
                                child: ElevatedButton(
                                  child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Detail',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListPerangkat(
                                          docClusterId: documentId,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    primary:
                                        const Color.fromARGB(225, 12, 144, 125),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
