import 'package:flutter/material.dart';
import 'package:socialapp/component.dart';

class NewPostScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: defaultAppBar(context: context,title: 'Add Post'));
  }
}