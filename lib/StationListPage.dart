// StationListPage.dart
import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;

  StationListPage({required this.title});

  final List<String> stations = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(); // 값을 돌려주지 않고 뒤로가기
          },
        ),
      ),
      body: ListView.separated(
        itemCount: stations.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final station = stations[index];
          return ListTile(
            title: Text(station),
            onTap: () {
              Navigator.of(context).pop(station); // 선택한 역 반환
            },
          );
        },
      ),
    );
  }
}
