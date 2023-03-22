import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ExpansionTileCardDemo extends StatefulWidget {
  const ExpansionTileCardDemo({Key? key}) : super(key: key);

  @override
  _ExpansionTileCardDemoState createState() => _ExpansionTileCardDemoState();
}

class _ExpansionTileCardDemoState extends State<ExpansionTileCardDemo> {
  final GlobalKey<ExpansionTileCardState> cardMekanik = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardElektrik = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardKd = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardSensor = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardIt = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardSipil = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // mekanik
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            // expandedColor: Colors.red[50],
            key: cardMekanik,
            title: const Text('Mekanik'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Nama",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () {
              //         cardMekanik.currentState?.expand();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const CircleBorder(),
              //         primary: const Color.fromARGB(225, 12, 144, 125),
              //       ),
              //       child: Column(
              //         children: const <Widget>[
              //           Icon(Icons.add),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // elektrik
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            // expandedColor: Colors.red[50],
            key: cardElektrik,
            title: const Text('Elektrik'),
            subtitle: const Text('Elektrik'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Nama",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () {
              //         cardMekanik.currentState?.expand();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const CircleBorder(),
              //         primary: const Color.fromARGB(225, 12, 144, 125),
              //       ),
              //       child: Column(
              //         children: <Widget>[
              //           IconButton(
              //             icon: const Icon(Icons.add),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => AddDynamic(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // komunikasi data
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            // expandedColor: Colors.red[50],
            key: cardKd,
            title: const Text('Komunikasi Data'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Nama",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () {
              //         cardMekanik.currentState?.expand();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const CircleBorder(),
              //         primary: const Color.fromARGB(225, 12, 144, 125),
              //       ),
              //       child: Column(
              //         children: <Widget>[
              //           IconButton(
              //             icon: const Icon(Icons.add),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => AddDynamic(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // sensor
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            // expandedColor: Colors.red[50],
            key: cardSensor,
            title: const Text('Sensor'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Nama",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () {
              //         cardMekanik.currentState?.expand();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const CircleBorder(),
              //         primary: const Color.fromARGB(225, 12, 144, 125),
              //       ),
              //       child: Column(
              //         children: <Widget>[
              //           IconButton(
              //             icon: const Icon(Icons.add),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => AddDynamic(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // IT
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            // expandedColor: Colors.red[50],
            key: cardIt,
            title: const Text('Information Technology'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Nama",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () {
              //         cardMekanik.currentState?.expand();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const CircleBorder(),
              //         primary: const Color.fromARGB(225, 12, 144, 125),
              //       ),
              //       child: Column(
              //         children: <Widget>[
              //           IconButton(
              //             icon: const Icon(Icons.add),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => AddDynamic(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // sipil
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            // expandedColor: Colors.red[50],
            key: cardSipil,
            title: const Text('Sipil'),
            subtitle: const Text('Deskripsi'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Nama",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     ElevatedButton(
              //       onPressed: () {
              //         cardMekanik.currentState?.expand();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const CircleBorder(),
              //         primary: const Color.fromARGB(225, 12, 144, 125),
              //       ),
              //       child: Column(
              //         children: <Widget>[
              //           IconButton(
              //             icon: const Icon(Icons.add),
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => AddDynamic(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // ExpansionTileCard(
        //   keyCard: cardMekanik,
        //   title: 'Mekanik',
        //   subtitle: 'Deskripsi',
        // ),
        // ExpansionTileCard(
        //   keyCard: cardElektrik,
        //   title: 'Elektrik',
        //   subtitle: 'Deskripsi',
        // ),
        // ExpansionTileCard(
        //   keyCard: cardKd,
        //   title: 'Komunikasi Data',
        //   subtitle: 'Deskripsi',
        // ),
        // ExpansionTileCard(
        //   keyCard: cardSensor,
        //   title: 'Sensor',
        //   subtitle: 'Deskripsi',
        // ),
        // ExpansionTileCard(
        //   keyCard: cardIt,
        //   title: 'Information Technology',
        //   subtitle: 'Deskripsi',
        // ),
        // ExpansionTileCard(
        //   keyCard: cardSipil,
        //   title: 'Sipil',
        //   subtitle: 'Deskripsi',
        // ),
      ],
    );
  }
}

// class ExpansionTileCard extends StatelessWidget {
//   final GlobalKey<ExpansionTileCardState>? keyCard;
//   final String? title;
//   final String? subtitle;

//   const ExpansionTileCard({
//     Key? key,
//     this.keyCard,
//     Color? baseColor,
//     this.title,
//     this.subtitle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
//       child: ExpansionTileCard(
//         baseColor: Colors.cyan[50],
//         // expandedColor: Colors.red[50],
//         key: keyCard,
//         title: title,
//         subtitle: subtitle,
//         // children: <Widget>[
//         //   const Divider(
//         //     thickness: 1.0,
//         //     height: 1.0,
//         //   ),
//         //   Align(
//         //     alignment: Alignment.centerLeft,
//         //     child: Padding(
//         //       padding: const EdgeInsets.symmetric(
//         //         horizontal: 16.0,
//         //         vertical: 8.0,
//         //       ),
//         //       child: Text(
//         //         "Nama",
//         //         style: Theme.of(context)
//         //             .textTheme
//         //             .bodyText2
//         //             ?.copyWith(fontSize: 16),
//         //       ),
//         //     ),
//         //   ),
//         //   ButtonBar(
//         //     alignment: MainAxisAlignment.end,
//         //     children: <Widget>[
//         //       ElevatedButton(
//         //         onPressed: () {
//         //           cardMekanik.currentState?.expand();
//         //         },
//         //         style: ElevatedButton.styleFrom(
//         //           shape: const CircleBorder(),
//         //           primary: const Color.fromARGB(225, 12, 144, 125),
//         //         ),
//         //         child: Column(
//         //           children: const <Widget>[
//         //             Icon(Icons.add),
//         //           ],
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ],
//       ),
//     );
//   }
// }
