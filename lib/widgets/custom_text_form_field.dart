import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Function onSave;
  final Function validate;
  final String hint;
  final int linesNumber;
  final String initalVal;
  final TextInputType keyboardType;
  final bool justRead;
  final String helpText;
  final List<TextInputFormatter> formatter;


  CustomTextFormField({
    this.label,
    this.onSave,
    this.validate,
    this.hint,
    this.linesNumber,
    this.initalVal,
    this.keyboardType,
    this.justRead,
    this.helpText,
    this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: linesNumber,
      initialValue: initalVal,
      keyboardType: keyboardType,
      readOnly: justRead,
      inputFormatters: formatter ,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        helperText: helpText,
        hintText: hint,
        labelStyle: TextStyle(
          fontSize: 20.0,
        ),
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onSaved: onSave,
      validator: validate,
    );
  }
}
