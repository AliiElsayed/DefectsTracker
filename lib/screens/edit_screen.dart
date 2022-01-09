import 'dart:io';
import 'dart:typed_data';

import 'package:defects_tracker/models/item_model.dart';
import 'package:defects_tracker/services/sqflite_database_helper/database_helper.dart';
import 'package:defects_tracker/widgets/custom_text.dart';
import 'package:defects_tracker/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../constants.dart';

class EditScreen extends StatefulWidget {
  final ItemModel model;
  EditScreen({this.model});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _key = GlobalKey<FormState>();
  DatabaseHelper dbHelper = DatabaseHelper();
  File pickedImage;

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.model.title}'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 5.0, right: 20.0, left: 20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                CustomTextFormField(
                  label: 'Item ID',
                  hint: 'Enter ItemId ',
                  initalVal: widget.model.id.toString(),
                  justRead: true,
                  onSave: (value) {
                    widget.model.id = int.parse(value);
                  },
                  validate: (value) {
                    if (value == '') {
                      return 'Item Id can not be Empty ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
                CustomTextFormField(
                  label: 'Title',
                  hint: 'Enter Title ',
                  justRead: false,
                  initalVal: widget.model.title,
                  onSave: (value) {
                    widget.model.title = value;
                  },
                  validate: (value) {
                    if (value == '') {
                      return 'Title can not be Empty ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
                CustomTextFormField(
                  label: 'Description',
                  hint: 'Enter Description ',
                  initalVal: widget.model.description,
                  justRead: false,
                  linesNumber: 4,
                  onSave: (value) {
                    widget.model.description = value;
                  },
                  validate: (value) {
                    if (value == '') {
                      return 'Description can not be Empty ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: _isPortrait
                          ? mediaQueryHeight * 0.30
                          : mediaQueryHeight * 0.70,
                      width: _isPortrait
                          ? mediaQueryWidth * 0.65
                          : mediaQueryWidth * 0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 2.0),
                          image: DecorationImage(
                            image: pickedImage == null
                                ? MemoryImage(widget.model.picture)
                                : FileImage(pickedImage),
                            fit: BoxFit.fill,
                          )),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 50.0,
                        color: Colors.grey.shade700,
                      ),
                      onTap: () {
                        pickImage();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    CustomText(
                      title: 'Status : ',
                      fontSize: 20.0,
                      fontColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 2.0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          // list in constants file to get choices
                          items: kDropdownButtonChoicesList
                              .map(
                                (choice) => DropdownMenuItem(
                                  value: choice,
                                  child: Text(choice),
                                ),
                              )
                              .toList(),
                          value: widget.model.status,
                          iconSize: 30.0,
                          onChanged: (value) {
                            setState(() {
                              widget.model.status = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: _isPortrait
                      ? mediaQueryHeight * 0.06
                      : mediaQueryHeight * 0.12,
                  child: ElevatedButton(
                    child: Text(
                      'Update Note',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        dbHelper.update(widget.model);
                        Toast.show(
                          "${widget.model.title.toUpperCase()} Note Updated Successfully",
                          context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    try {
      PickedFile _image = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 15);
      if (_image != null) {
        Uint8List imageBytes =
            await File(_image.path).readAsBytes(); //convert to bytes

        setState(() {
          pickedImage = File(_image.path);
          widget.model.picture = imageBytes;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }
}
