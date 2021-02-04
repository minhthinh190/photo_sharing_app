import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_sharing_app/widgets/widget.dart';
import 'package:photo_sharing_app/model/photo_model.dart';
import 'package:photo_sharing_app/data/data.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotoModel> photos = new List();

  TextEditingController searchController = new TextEditingController();

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
    getSearchedPhotos(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
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
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffeceff1),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getSearchedPhotos(searchController.text);
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              photoList(photos: photos, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
