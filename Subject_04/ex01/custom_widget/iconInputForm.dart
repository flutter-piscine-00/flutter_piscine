import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconInput extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  final String hintText;
  final void Function(String?)? inputSaveHandler;
  final void Function(String)? inputEditingCompletetHandler;
  final IconData prefixIconData;
  final IconData? subFixIconData;
  final String? inputValue;

  IconInput(
      {required this.hintText,
      required this.prefixIconData,
      this.inputEditingCompletetHandler,
      this.subFixIconData,
      this.inputSaveHandler,
      this.inputValue});

  @override
  _IconInputState createState() => _IconInputState();
}

class _IconInputState extends State<IconInput> {
  late final TextEditingController _myController;
  @override
  void initState() {
    super.initState();
    _myController = TextEditingController(text: widget.inputValue);
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  Widget? _buildSuffix() {
    if (widget.subFixIconData == null) {
      return null;
    } else {
      return IconButton(
        icon: Icon(widget.subFixIconData),
        onPressed: () {
          if (widget._formKey.currentState!.validate()) {
            widget._formKey.currentState!.save();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: TextFormField(
        controller: _myController,
        onEditingComplete: () {
          if (widget.inputEditingCompletetHandler != null) {
            widget.inputEditingCompletetHandler!(_myController.text);
          }
        },
        onSaved: widget.inputSaveHandler,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Input Keyword';
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIconData),
          suffixIcon: _buildSuffix(),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
