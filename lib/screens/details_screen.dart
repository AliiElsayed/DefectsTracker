import 'package:defects_tracker/models/item_model.dart';
import 'package:defects_tracker/screens/edit_screen.dart';
import 'package:defects_tracker/screens/show_full_image.dart';
import 'package:defects_tracker/services/sqflite_database_helper/database_helper.dart';
import 'package:defects_tracker/widgets/custom_button.dart';
import 'package:defects_tracker/widgets/custom_text.dart';
import 'package:defects_tracker/widgets/light_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../constants.dart';

class DetailsScreen extends StatelessWidget {
  final ItemModel model;
  DetailsScreen({this.model});
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(' ${model.title} Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isPortrait
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ShowFullImage(
                                      image: model.picture,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: mediaQueryWidth,
                                height: mediaQueryHeight * 0.29,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Hero(
                                    tag: model.picture,
                                    child: Image.memory(
                                      model.picture,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 13.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: model.id.toString(),
                                    fontSize: 25.0,
                                    fontColor: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                    child: CustomText(
                                      title: ' :',
                                      fontSize: 25.0,
                                      fontColor: kSecondaryColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      title: model.title,
                                      fontSize: 23.0,
                                      fontColor: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomLightContainer(
                              title: 'Date :',
                              pickedDate: model.date,
                            ),
                            CustomLightContainer(
                              title: 'Status :',
                              inspectingStatus: model.status,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ShowFullImage(
                                      image: model.picture,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: mediaQueryWidth * 0.4,
                                height: mediaQueryHeight * 0.6,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Hero(
                                    tag: model.picture,
                                    child: Image.memory(
                                      model.picture,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title: model.id.toString(),
                                          fontSize: 25.0,
                                          fontColor: kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                          child: CustomText(
                                            title: ' :',
                                            fontSize: 25.0,
                                            fontColor: kSecondaryColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            title: model.title,
                                            fontSize: 23.0,
                                             fontColor:kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomLightContainer(
                                    title: 'Date :',
                                    pickedDate: model.date,
                                  ),
                                  CustomLightContainer(
                                    title: 'Status :',
                                    inspectingStatus: model.status,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: _isPortrait ? 20.0 : 15.0,
                    child: Divider(
                      color: Colors.brown,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.0),
                    child: CustomText(
                      title: 'Description',
                      fontSize: 24.0,
                      fontColor: kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.0),
                    child: CustomText(
                      title: model.description,
                      fontSize: 18.0,
                      linesHeight: 1.7,
                      linesNum: 100,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                    child: Divider(
                      color: Colors.brown,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  btnTitle: 'Edit Note',
                  onBtnPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditScreen(
                          model: model,
                        ),
                      ),
                    );
                  },
                ),
                CustomButton(
                  btnTitle: 'Delete Note',
                  onBtnPressed: () {
                    DatabaseHelper().deleteItem(model.id);
                    Toast.show(
                      "${model.title.toUpperCase()} Note Deleted Successfully",
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
