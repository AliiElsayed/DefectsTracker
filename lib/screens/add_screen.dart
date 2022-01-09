import 'dart:typed_data';
import 'dart:io';
import 'package:defects_tracker/constants.dart';
import 'package:defects_tracker/models/item_model.dart';
import 'package:defects_tracker/services/sqflite_database_helper/database_helper.dart';
import 'package:defects_tracker/widgets/custom_text.dart';
import 'package:defects_tracker/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  File pickedImage; // for just display in the screen
  Uint8List usedPickedImage; // to  store and retrieve
  int id;
  String title;
  String description;
  String selectedStatus;
  DatabaseHelper dbHelper = DatabaseHelper();
  String noSelectedOptionError;
  String noPickedPhotoError;
  String checker = '';

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 5.0, right: 20.0, left: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  label: 'Item ID',
                  hint: 'Enter Item Id ',
                  keyboardType: TextInputType.number,
                  justRead: false,
                  formatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'\d'),
                    ),
                  ],
                  helpText: 'Note : Id must be Numbers Only ex : 23',
                  onSave: (value) {
                    id = int.parse(value);
                  },
                  validate: (value) {
                    if (value == '') {
                      return 'Item Id can not be Empty ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  label: 'Title',
                  hint: 'Enter Title ',
                  justRead: false,
                  onSave: (value) {
                    title = value;
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
                  justRead: false,
                  linesNumber: 4,
                  onSave: (value) {
                    description = value;
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
                      height:  _isPortrait? mediaQueryHeight * 0.30: mediaQueryHeight * 0.70,
                      width: _isPortrait? mediaQueryWidth*0.65: mediaQueryWidth*0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 2.0),
                          image: DecorationImage(
                            image: pickedImage == null
                                ? AssetImage(
                                    'assets/images/empty_image.png',
                                  )
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
                noPickedPhotoError == null
                    ? SizedBox.shrink()
                    : CustomText(
                        title: noPickedPhotoError,
                        fontColor: Colors.red.shade800,
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
                      width: mediaQueryWidth * 0.65,
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
                          value: selectedStatus,
                          iconSize: 30.0,
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                noSelectedOptionError == null
                    ? SizedBox.shrink()
                    : CustomText(
                        title: noSelectedOptionError,
                        fontColor: Colors.red.shade800,
                      ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  width: mediaQueryWidth * 0.93,
                  height:  _isPortrait?mediaQueryHeight * 0.06:mediaQueryHeight * 0.12,
                  child: ElevatedButton(
                    child: Text(
                      'Add Note',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      _validateForm( context);
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
          usedPickedImage = imageBytes;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  void _validateForm( context ) {
    bool _isValid = _formKey.currentState.validate();
    if (selectedStatus == null) {
      setState(() {
        noSelectedOptionError = 'Please, select a status!';
      });
      _isValid = false;
    }
    if (pickedImage == null) {
      setState(() {
        noPickedPhotoError = 'Please, take a Photo !';
      });
      _isValid = false;
    }
    if (_isValid) {
      _formKey.currentState.save();
         dbHelper.insert(context,ItemModel(
          title: title,
          id: id,
          description: description,
          status: selectedStatus,
          date: DateTime.now(),
          picture: usedPickedImage,
        )).then((value){
          if(value !=0){
            Toast.show(
              "${title.toUpperCase()} Note Added Successfully",
              context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM,
            );
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          }else{
            print('insert error');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds:5),
              backgroundColor: Colors.white.withOpacity(0.6),
              elevation: 3.0,
              padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 5.0),
              content: CustomText(
                title: ' Id exist Try another one',fontSize: 18.0,
                fontColor: Colors.black87,
              ),
            ));
          }

        });

    }
  }
}
