import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SecondPage extends StatelessWidget {
  final double bmi;

  SecondPage({required this.bmi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: BMIGauge(
        nowValue: bmi,
      ),
    );
  }
}

class BMIGauge extends StatefulWidget {
  final double nowValue;

  BMIGauge({required this.nowValue});
  @override
  _BMIGaugeState createState() => _BMIGaugeState();
}

class _BMIGaugeState extends State<BMIGauge> {
  late bool dataVisible;

  double _doubleRoundOne(double value) {
    value *= 10;
    final intValue = value.round();
    return intValue / 10;
  }

  @override
  void initState() {
    super.initState();
    dataVisible = false;

    final cb = () {
      setState(() {
        dataVisible = true;
      });
    };

    new Timer(new Duration(milliseconds: 500), cb);
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 45,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 18.5,
              color: Colors.blue,
              label: '저체중',
            ),
            GaugeRange(
              startValue: 18.5,
              endValue: 25,
              color: Colors.green,
              label: '정상',
            ),
            GaugeRange(
              startValue: 25,
              endValue: 30,
              color: Colors.yellow,
              label: '과체중',
            ),
            GaugeRange(
              startValue: 30,
              endValue: 35,
              color: Colors.red[200],
              label: '비만',
            ),
            GaugeRange(
              startValue: 35,
              endValue: 45,
              color: Colors.red,
              label: '고도비만',
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              onValueChanged: (value) {
                print('onValueChanged');
              },
              value: widget.nowValue,
              enableAnimation: true,
              animationDuration: 500,
              animationType: AnimationType.linear,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: AnimatedOpacity(
                  opacity: dataVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    child: Text(
                      'BMI : ${_doubleRoundOne(widget.nowValue)}',
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                angle: 90,
                positionFactor: 0.75)
          ],
        ),
      ],
    );
  }
}
