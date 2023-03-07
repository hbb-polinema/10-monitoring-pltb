import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:manajemen_aset/models/cluster.dart';
import 'package:manajemen_aset/pages/perangkat/perangkat_list_page.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> with TickerProviderStateMixin {
  final pageController = PageController();
  int selectedIndex = 0;
  var currentLocation = LatLng(-0.789275, 113.921327);

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
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
                markers: [
                  for (int i = 0; i < mapCluster.length; i++)
                    Marker(
                      height: 40,
                      width: 40,
                      point:
                          mapCluster[i].lokasi ?? LatLng(-0.789275, 113.921327),
                      builder: (_) {
                        return IconButton(
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
                                          const Text(
                                            'Cluster Tuban',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Divider(
                                            thickness: 2,
                                            color: Colors.black45,
                                          ),
                                          const SizedBox(height: 16),
                                          // produksi energi
                                          const Text(
                                            "Produksi Energi (kWh",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Image(
                                                    image: AssetImage(
                                                        'img/pltb.png'),
                                                    width: 50,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'PLTB',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    '100',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          225, 12, 144, 125),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: const [
                                                  Image(
                                                    image: AssetImage(
                                                        'img/plts.png'),
                                                    width: 50,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'PLTS',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    '100',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          225, 12, 144, 125),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: const [
                                                  SizedBox(height: 8),
                                                  Image(
                                                    image: AssetImage(
                                                        'img/pltd.png'),
                                                    width: 50,
                                                  ),
                                                  Text(
                                                    'Diesel',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    '100',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          225, 12, 144, 125),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: const [
                                                  Image(
                                                    image: AssetImage(
                                                        'img/energy.png'),
                                                    width: 50,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    '100',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          225, 12, 144, 125),
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
                                          // chart monitoring produksi energi
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text(
                                                    'Realtime',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.stacked_line_chart,
                                                ),
                                              )
                                            ],
                                          ),
                                          // tombol detail
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              child: const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ListPerangkat(),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                primary: const Color.fromARGB(
                                                    225, 12, 144, 125),
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
                        );
                        // return GestureDetector(
                        //   onTap: () {
                        //     pageController.animateToPage(
                        //       i,
                        //       duration: const Duration(milliseconds: 500),
                        //       curve: Curves.easeInOut,
                        //     );
                        //     selectedIndex = i;
                        //     currentLocation = mapCluster[i].lokasi ??
                        //         LatLng(-0.789275, 113.921327);
                        //     _animatedMapMove(currentLocation, 11.5);
                        //     setState(() {});
                        //   },
                        //   child: AnimatedScale(
                        //     duration: const Duration(milliseconds: 500),
                        //     scale: selectedIndex == i ? 1 : 0.7,
                        //     child: AnimatedOpacity(
                        //       duration: const Duration(milliseconds: 500),
                        //       opacity: selectedIndex == i ? 1 : 0.5,
                        //       child: const Icon(
                        //         Icons.wind_power,
                        //         color: Colors.indigo,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                ],
              ),
            ],
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 2,
          //   height: MediaQuery.of(context).size.height * 0.3,
          //   child: PageView.builder(
          //     controller: pageController,
          //     onPageChanged: (value) {
          //       selectedIndex = value;
          //       currentLocation =
          //           mapCluster[value].lokasi ?? LatLng(-0.789275, 113.921327);
          //       _animatedMapMove(currentLocation, 11.5);
          //       setState(() {});
          //     },
          //     itemCount: mapCluster.length,
          //     itemBuilder: (_, index) {
          //       final item = mapCluster[index];
          //       return Padding(
          //         padding: const EdgeInsets.all(15.0),
          //         child: Card(
          //           elevation: 5,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           color: const Color.fromARGB(255, 255, 255, 255),
          //           child: Row(
          //             children: [
          //               const SizedBox(width: 10),
          //               Expanded(
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Expanded(
          //                       flex: 2,
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           const SizedBox(height: 10),
          //                           Text(
          //                             item.nama ?? '',
          //                             style: const TextStyle(
          //                               fontSize: 20,
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                           const SizedBox(height: 10),
          //                           Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Column(
          //                                 children: const [
          //                                   Text(
          //                                     'WT-Tuban.01',
          //                                     style: TextStyle(
          //                                       fontSize: 20,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                               IconButton(
          //                                 onPressed: () {},
          //                                 icon: const Icon(
          //                                   Icons.warning,
          //                                   color: Colors.yellow,
          //                                 ),
          //                               )
          //                             ],
          //                           ),
          //                           const SizedBox(height: 10),
          //                           Container(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 16),
          //                             width: double.infinity,
          //                             child: ElevatedButton(
          //                               child: const Padding(
          //                                 padding: EdgeInsets.all(16.0),
          //                                 child: Text(
          //                                   'Detail',
          //                                   style: TextStyle(
          //                                       fontSize: 16,
          //                                       fontWeight: FontWeight.w500),
          //                                 ),
          //                               ),
          //                               onPressed: () {
          //                                 Navigator.push(
          //                                   context,
          //                                   MaterialPageRoute(
          //                                     builder: (context) =>
          //                                         const ListPerangkat(),
          //                                   ),
          //                                 );
          //                               },
          //                               style: ElevatedButton.styleFrom(
          //                                 shape: RoundedRectangleBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(10),
          //                                 ),
          //                                 primary: const Color.fromARGB(
          //                                     225, 12, 144, 125),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               const SizedBox(width: 10),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
