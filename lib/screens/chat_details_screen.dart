import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen(this.userModel);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userModel.image),
                        radius: 20.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(userModel.name)
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ConditionalBuilder(
                        condition: SocialCubit.get(context).messages.length > 0,
                        builder: (context) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).messages[index];
                                if (SocialCubit.get(context).userModel.uId ==
                                    message.senderId)
                                  return buildMyMessages(message);

                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15.0,
                                  ),
                              itemCount:
                                  SocialCubit.get(context).messages.length);
                        },
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                    hintText: 'write message here ...',
                                    border: InputBorder.none),
                              ),
                            )),
                            MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    text: textController.text,
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString());
                              },
                              child: Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          });
    });
  }
}

Widget buildMessage(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0))),
        child: Text(messageModel.text),
      ),
    );
Widget buildMyMessages(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0))),
        child: Text(messageModel.text),
      ),
    );
