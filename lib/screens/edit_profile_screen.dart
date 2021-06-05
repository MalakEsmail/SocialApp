import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();

  File image;
  var picker = ImagePicker();
  
  Future<void> getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

     if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
     
  
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var model = SocialCubit.get(context).userModel;

          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Edit Profile',
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Update',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  )
                ]),
            body: Padding(
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
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0)),
                                  image: DecorationImage(
                                      image: NetworkImage('${model.cover}'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: CircleAvatar(
                                    child: Icon(Icons.camera_alt),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage('${model.image}'),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  child: Icon(Icons.camera_alt),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        //  else null;
                      },
                      label: 'Name',
                      prefix: Icons.person),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty';
                        }
                        //  else null;
                      },
                      label: 'Bio',
                      prefix: Icons.info_outline),
                ],
              ),
            ),
          );
        },
        listener: (conext, state) {});
  }
}
