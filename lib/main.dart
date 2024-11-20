// main.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'StationListPage.dart';
import 'SeatPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // 앱의 루트 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Train App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: HomePage(), // 앱 시작 시 표시할 화면
      onGenerateRoute: (settings) {
        if (settings.name == '/stationList') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return StationListPage(title: args['title']);
            },
          );
        } else if (settings.name == '/seatSelection') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return SeatPage(
                departureStation: args['departureStation'],
                arrivalStation: args['arrivalStation'],
              );
            },
          );
        }
        return MaterialPageRoute(builder: (context) => HomePage());
      },
    );
  }
}
