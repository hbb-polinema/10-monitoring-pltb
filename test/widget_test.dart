// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:manajemen_aset/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
// String url = 'https://ebt-polinema.id/api/wind-turbine/status';

// final http.Response res = await http.post(
//   Uri.parse(url),
//   // body: jsonEncode(<String, dynamic>{
//   //   'id': id,
//   //   'nextDate': nextDate,
//   //   'draw': draw
//   // }),
// );

// if (res.statusCode == 200) {
//   final jsonRes = json.decode(res.body);
//   final dataMap = jsonRes['res'];
//   List data = dataMap.map((i) => MonitoringData.fromJson(i)).toList();
//   print(data);
//   return data;
// } else {
//   throw Exception('Failed to get data.');
// }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/monitoring_data.dart';

void main() async {
  // http.Response response = await createUser("a", "b");
  String response =
      await getRealData("1", DateTime.parse("2023-01-13 20:01:15"), "2");
  print(response);
  // List<MonitoringData> chartData = [];
  // String jsonString = await getRealData("1", DateTime.now(), "1");
  // final data = jsonDecode(jsonString);
  // print(data);

  // for (Map<String, dynamic> i in data) {
  //   chartData.add(MonitoringData.fromJson(i));
  // }
}

Future<http.Response> createUser(String name, String job) {
  return http.post(
    Uri.parse('https://reqres.in/api/users'),
    body: jsonEncode(<String, String>{'name': name, 'job': job}),
  );
}

Future<String> getRealData(String id, DateTime date, String draw) async {
  final http.Response res = await http.post(
    Uri.parse('https://ebt-polinema.id/api/wind-turbine/status'),
    body: jsonEncode(<String, dynamic>{
      'id': id,
      'real_data': [
        {'date': date.toIso8601String()}
      ],
      'calc_data': [
        {'date': date.toIso8601String()}
      ],
      'next_date': date.toIso8601String() ,
      'draw': draw
    }),
  );
  return res.body;
  // return MonitoringData.fromJson(json.decode(res.body));
}
