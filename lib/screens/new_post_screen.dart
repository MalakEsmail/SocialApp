import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return Scaffold(
            appBar:
                defaultAppBar(context: context, title: 'Create Post', actions: [
              Container(
                color: Colors.white,
                child: defaultTextButton(
                    function: () {
                      var now = DateTime.now();

                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      } else {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      }
                    },
                    text: 'Post',),
              )
            ]),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            'https://image.freepik.com/free-photo/portrait-young-beautiful-playful-woman-with-bun-posing_176420-12392.jpg'),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child:
                            Text('Malak Esmail', style: TextStyle(height: 1.4)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'Whats on your mind ...',
                          border: InputBorder.none),
                    ),
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 180.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: FileImage(SocialCubit.get(context).postImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: CircleAvatar(
                              child: Icon(Icons.close),
                            ))
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              SocialCubit.get(context).getPostImage();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('add photo')
                              ],
                            )),
                      ),
                      Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text('# tags')),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
