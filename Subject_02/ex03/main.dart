import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  PreferredSizeWidget _buildAppBar(String titleText) {
    return AppBar(title: Text(titleText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar('BMI Calculator'),
      body: BMIInputForm(),
    );
  }
}

class BMIInputForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _BMIInputFormState createState() => _BMIInputFormState();
}

class _BMIInputFormState extends State<BMIInputForm> {
  late int height; // (cm)
  late int weight; // (kg)
  late bool isShowWeight; //

  @override
  void initState() {
    super.initState();
    height = 1;
    weight = 1;
    isShowWeight = false;
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _heightChangeHandler(String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return;
    } else {
      setState(() => {height = int.parse(newValue)});
      return;
    }
  }

  void _weightChangeHandler(String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return;
    } else {
      setState(() => {weight = int.parse(newValue)});
      return;
    }
  }

  double _calcBMI() {
    final k = height * height / 10000;
    final bmi = weight / k;
    return bmi >= 45 ? 45 : bmi;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: widget._formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              IntInput(
                label: 'Height(cm)',
                saveHandler: _heightChangeHandler,
              ),
              const SizedBox(height: 16),
              IntInput(
                label: 'Weight(kg)',
                isWithValueHideSwitch: true,
                saveHandler: _weightChangeHandler,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget._formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          widget._formKey.currentState!.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => SecondPage(
                                        bmi: _calcBMI(),
                                      )));
                        } else {
                          _showSnackBar('Error');
                        }
                      },
                      child: const Text('Calculation'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IntInput extends StatefulWidget {
  final String label;
  final bool isWithValueHideSwitch;
  final void Function(String? newValue) saveHandler;

  IntInput(
      {required this.label,
      required this.saveHandler,
      this.isWithValueHideSwitch = false});

  @override
  _IntInputState createState() => _IntInputState();
}

class _IntInputState extends State<IntInput> {
  late bool isValueHide;
  late String switchText;

  @override
  void initState() {
    super.initState();
    isValueHide = false;
    switchText = 'digit';
  }

  Widget _getSwich() {
    if (!widget.isWithValueHideSwitch)
      return Container();
    else {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: CupertinoSwitch(
              value: isValueHide,
              onChanged: (isOn) {
                setState(() {
                  isValueHide = isOn;
                  switchText = isOn ? '****' : 'digit';
                });
              },
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text('${widget.label} : $switchText')),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onSaved: widget.saveHandler,
          obscureText: isValueHide,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Input ${widget.label}';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Input ${widget.label}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        _getSwich()
      ],
    );
  }
}
