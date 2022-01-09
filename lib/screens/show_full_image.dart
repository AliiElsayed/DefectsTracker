import 'dart:typed_data';

import 'package:flutter/material.dart';

class ShowFullImage extends StatelessWidget {
  final Uint8List image;

  ShowFullImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: image,
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 1.6,
              child: Image.memory(
                image,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
