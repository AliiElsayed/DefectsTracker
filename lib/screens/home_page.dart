import 'package:defects_tracker/screens/details_screen.dart';
import 'package:defects_tracker/services/sqflite_database_helper/database_helper.dart';
import 'package:defects_tracker/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getItems(); // to get all stored items
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('All Notes'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : dbHelper.allItems.isEmpty
              ? Center(
                  child: CustomText(
                    title: 'No items added yet ...',
                    fontSize: 25.0,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  color: Colors.white,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  model: dbHelper.allItems[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(11.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                  offset: Offset(1, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: _isPortrait
                                      ? mediaQueryWidth * 0.40
                                      : mediaQueryWidth * 0.20,
                                  height: _isPortrait
                                      ? mediaQueryHeight * 0.23
                                      : mediaQueryHeight * 0.50,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.memory(
                                        dbHelper.allItems[index].picture),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: _isPortrait
                                        ? mediaQueryHeight * 0.23
                                        : mediaQueryHeight * 0.50,
                                    padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 12.0,
                                      right: 14.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title: dbHelper.allItems[index].id
                                              .toString(),
                                          fontColor: Colors.black,
                                          fontSize: 17.0,
                                        ),
                                        CustomText(
                                          title: dbHelper.allItems[index].title,
                                          fontColor: kPrimaryColor,
                                          fontSize: 24.0,
                                          linesNum: 1,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            title: dbHelper
                                                .allItems[index].description,
                                            fontColor: Colors.black,
                                            fontSize: 15.0,
                                            linesNum: 2,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: _isPortrait
                                                ? mediaQueryHeight * 0.04
                                                : mediaQueryHeight * 0.1,
                                            width: _isPortrait
                                                ? mediaQueryWidth * 0.20
                                                : mediaQueryWidth * 0.22,
                                            decoration: BoxDecoration(
                                              color:kSecondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                title: dbHelper
                                                    .allItems[index].status,
                                                fontColor: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.0,
                        );
                      },
                      itemCount: dbHelper.allItems.length),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kSecondaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/AddScreen');
        },
      ),
    );
  }

  getItems() async {
    loading = true;
    await dbHelper.getAllItems().then((value) {
      setState(() {
        dbHelper.allItems = value;
      });
    });
    loading = false;
  }
}
