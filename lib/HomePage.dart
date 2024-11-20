// HomePage.dart
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String departureStation = '선택'; // 초기값 설정
  String arrivalStation = '선택';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'),        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 출발역 및 도착역 감싸고 있는 박스
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 출발역 선택
                  GestureDetector(
                    onTap: () async {
                      final selectedStation = await Navigator.pushNamed(
                        context,
                        '/stationList',
                        arguments: {'title': '출발역'},
                      );
                      if (selectedStation != null && selectedStation is String) {
                        setState(() {
                          departureStation = selectedStation;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '출발역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          departureStation,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 세로선
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  // 도착역 선택
                  GestureDetector(
                    onTap: () async {
                      final selectedStation = await Navigator.pushNamed(
                        context,
                        '/stationList',
                        arguments: {'title': '도착역'},
                      );
                      if (selectedStation != null && selectedStation is String) {
                        setState(() {
                          arrivalStation = selectedStation;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '도착역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          arrivalStation,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // 좌석 선택 버튼
            ElevatedButton(
              onPressed: (departureStation != '선택' && arrivalStation != '선택')
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/seatSelection',
                        arguments: {
                          'departureStation': departureStation,
                          'arrivalStation': arrivalStation,
                        },
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                '좌석 선택',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
