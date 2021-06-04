import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 220.0,
            child: Stack(
              
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    
                    height: 180.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/young-beautiful-brunette-businesswoman-smiling-pointing-finger-side_176420-9920.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/portrait-young-beautiful-playful-woman-with-bun-posing_176420-12392.jpg'),
                  ),
                )
              ],
            ),
          ),
        
        Text('Malak Esmail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)],
      ),
    );
  }
}
