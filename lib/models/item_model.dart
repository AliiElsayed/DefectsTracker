import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ItemModel {
  @required
  int id;
  @required
  String title;
  @required
  Uint8List picture;
  @required
  String description;
  @required
  DateTime date;
  @required
  String status;

  ItemModel(
      {this.id,
      this.title,
      this.picture,
      this.description,
      this.date,
      this.status});

  ItemModel.fromJson(Map<String, dynamic> itemData) {
    if (itemData == null) {
      return;
    }
    id = itemData['id'];
    title = itemData['title'];
    picture = itemData['picture'];
    description = itemData['description'];
    date = DateTime.fromMillisecondsSinceEpoch(itemData['date']);
    status = itemData['status'];
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'picture': picture,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'status': status,
    };
  }
}
