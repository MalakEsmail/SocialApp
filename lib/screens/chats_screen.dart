import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/screens/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildChatItem(
                    SocialCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state) {});
  }
}

Widget buildChatItem(UserModel model, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, ChatDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text('${model.name}', style: TextStyle(height: 1.4)),
        ],
      ),
    ),
  );
}
