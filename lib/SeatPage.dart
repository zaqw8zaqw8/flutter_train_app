// SeatPage.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  SeatPage({required this.departureStation, required this.arrivalStation});

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<bool>> seats =
      List.generate(20, (index) => List.generate(4, (index) => false));

  final List<String> seatLabels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0), // 위 아래로 패딩 20
        child: Column(
          children: [
            // 출발역과 도착역 출력
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departureStation,
                  style: TextStyle(
                    fontSize: 30, // 글자 크기 30
                    fontWeight: FontWeight.bold, // 글자 두께: bold
                    color: Colors.purple, // 글자 색상: 보라색
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_circle_right_outlined, // 화살표 아이콘
                  size: 30, // 아이콘 크기: 30
                ),
                SizedBox(width: 10),
                Text(
                  widget.arrivalStation,
                  style: TextStyle(
                    fontSize: 30, // 글자 크기 30
                    fontWeight: FontWeight.bold, // 글자 두께: bold
                    color: Colors.purple, // 글자 색상: 보라색
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // 좌석 상태 안내 레이블
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SeatLegend(color: Colors.purple, label: '선택됨'),
                SizedBox(width: 20), // 선택됨, 선택안됨 간격 20
                SeatLegend(color: Colors.grey[300]!, label: '선택안됨'),
              ],
            ),
            SizedBox(height: 20),
            // ABCD 레이블
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: seatLabels.map((label) {
                  return Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 18), // 글자 크기: 18
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 8),
            // 좌석 리스트
            Expanded(
              child: ListView.builder(
                itemCount: seats.length, // 총 20개의 행 스크롤
                itemBuilder: (context, rowIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0), // 좌석 위젯들의 세로 간격: 8 (위아래로 4씩)
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 행 번호 출력
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            '${rowIndex + 1}',
                            style: TextStyle(fontSize: 18), // 글자 크기: 18
                          ),
                        ),
                        SizedBox(width: 8),
                        // 좌석 위젯들
                        ...List.generate(4, (colIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0), // 좌석 위젯의 가로 간격: 4 (좌우로 2씩)
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  seats[rowIndex][colIndex] = !seats[rowIndex][colIndex];
                                });
                              },
                              child: Container(
                                width: 50, // 좌석 위젯 너비: 50
                                height: 50, // 좌석 위젯 높이: 50
                                decoration: BoxDecoration(
                                  color: seats[rowIndex][colIndex]
                                      ? Colors.purple // 선택됨: 보라색
                                      : Colors.grey[300], // 선택안됨: 회색
                                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기: 8
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
            // 예매하기 버튼
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: seats.any((row) => row.contains(true))
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text('예매 확인'),
                            content: Text('좌석을 예매하시겠습니까?'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('취소'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Dialog 닫기
                                  Navigator.of(context).pop(); // SeatPage 닫기
                                  Navigator.of(context).pop(); // HomePage로 이동
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // 버튼 색상: 보라색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 모서리 둥글기: 20
                  ),
                ),
                child: Text(
                  '예매 하기',
                  style: TextStyle(
                    color: Colors.white, // 글자 색상: 흰색
                    fontSize: 18, // 글자 크기: 18
                    fontWeight: FontWeight.bold, // 글자 두께: bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatLegend extends StatelessWidget {
  final Color color;
  final String label;

  SeatLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24, // 너비: 24
          height: 24, // 높이: 24
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8), // 모서리 둥글기: 8
          ),
        ),
        SizedBox(width: 4), // 좌석 상태 박스와 텍스트의 간격: 4
        Text(label), // 별도의 스타일 지정 없음
      ],
    );
  }
}
