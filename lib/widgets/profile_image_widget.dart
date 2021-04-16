import 'dart:io';

import 'package:flutter/material.dart';
import 'package:select_profile_photo/select_profile_photo.dart';

class ProfileImage extends StatelessWidget {
  var imagesFile = <File>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 80.0, 10.0, 30.0),
            child: Text(
              'Profil Fotoğrafını seç',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ImagePicker(
            itemCount: 3,
            height: 120.0,
            backgroundColor: Colors.black,
            backgroundImage: Colors.white,
            iconColor: Colors.red,
            iconEditColor: Colors.red,
            iconAddColor: Colors.white,
            selectionPhoto: (file) {
              imagesFile = file;
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                Text(
                  'Nerdeyse hazırsın',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
