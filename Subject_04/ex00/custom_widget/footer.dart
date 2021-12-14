import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Elevation95(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 40,
                    child: Text(
                      '> 전화 접속번호 변경 : 01421 -> 1544-1421',
                      style: Flutter95.textStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Elevation95(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 40,
                    child: Text(
                      '> 웹 커뮤니티의 최강자! 인/터/넷/나/우/누/리',
                      style: Flutter95.textStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
