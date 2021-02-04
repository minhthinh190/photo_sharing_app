import 'package:flutter/material.dart';
import 'package:photo_sharing_app/model/photo_model.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'Photo',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      Text(
        'Sharing',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      Text(
        'App',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget photoList({List<PhotoModel> photos, context}) {
  return Container(
    margin: EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 6.0,
      children: photos.map((photo) {
        return GridTile(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(photo.src.portrait, fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
