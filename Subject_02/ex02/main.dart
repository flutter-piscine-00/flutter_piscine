import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return FirstRoute();
  }
}

class ThreePartGauge extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final double nowValue;

  ThreePartGauge(
      {required this.minValue, required this.maxValue, required this.nowValue});

  double _getEndValue(int th) {
    return minValue + ((maxValue - minValue) / 3) * th;
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: minValue,
          maximum: maxValue,
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: minValue,
                endValue: _getEndValue(1),
                color: Colors.green),
            GaugeRange(
                startValue: _getEndValue(1),
                endValue: _getEndValue(2),
                color: Colors.orange),
            GaugeRange(
                startValue: _getEndValue(2),
                endValue: _getEndValue(3),
                color: Colors.red)
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: nowValue,
              needleColor: Colors.white,
              knobStyle: KnobStyle(color: Colors.white),
              enableAnimation: true,
              animationDuration: 500,
              animationType: AnimationType.linear,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                  child: Text(
                    '${nowValue}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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

class GreenSlider extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final double nowValue;
  final void Function(double newValue) valueChangeHanlder;

  GreenSlider(
      {required this.minValue,
      required this.maxValue,
      required this.nowValue,
      required this.valueChangeHanlder});

  @override
  Widget build(BuildContext) {
    return (SliderTheme(
      data: SliderThemeData(
        activeTrackColor: Colors.green,
        // inactiveTrackColor: Colors.red,
        thumbColor: Colors.green,
        activeTickMarkColor: Colors.green,
        valueIndicatorColor: Colors.green,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 10.0,
          elevation: 1,
        ),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      ),
      child: Slider(
        value: nowValue,
        min: minValue,
        max: maxValue,
        onChanged: valueChangeHanlder,
      ),
    ));
  }
}

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  late double minValue;
  late double maxValue;
  late double nowValue;

  @override
  void initState() {
    super.initState();
    minValue = 0;
    maxValue = 150;
    nowValue = 0.0;
  }

  double _doubleRoundOne(double value) {
    value *= 10;
    final intValue = value.round();
    return intValue / 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Fluent Gauge', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Center(
        child: Container(
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThreePartGauge(
                maxValue: maxValue,
                minValue: minValue,
                nowValue: nowValue,
              ),
              GreenSlider(
                maxValue: maxValue,
                minValue: minValue,
                nowValue: nowValue,
                valueChangeHanlder: (value) {
                  setState(() => {nowValue = _doubleRoundOne(value)});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
