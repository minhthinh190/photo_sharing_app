import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/widgets/widget.dart';
import 'package:photo_sharing_app/model/photo_model.dart';
import 'package:photo_sharing_app/data/data.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String categoryName;
  Category({this.categoryName});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<PhotoModel> photos = new List();

  getSearchedPhotos(String query) async {
    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=16",
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      PhotoModel photoModel = new PhotoModel();
      photoModel = PhotoModel.fromMap(element);
      photos.add(photoModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchedPhotos(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              photoList(photos: photos, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
