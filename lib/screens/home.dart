import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('New Feed'),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              builder: (context) {
               // var model = SocialCubit.get(context).model;
                return Column(
                  children: [
                    /*  if (!FirebaseAuth.instance.currentUser.emailVerified)
                      Container(
                        color: Colors.amber.withOpacity(0.5),
                        height: 50.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Text('please verify your email'),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              defaultTextButton(
                                  function: () {
                                    FirebaseAuth.instance.currentUser
                                        .sendEmailVerification()
                                        .then((value) {
                                      showToast(
                                          text: 'check your mail',
                                          state: ToastStates.SUCCESS);
                                    }).catchError((error) {

                                    });
                                  },
                                  text: 'send ')
                            ],
                          ),
                        ),
                      )
                 */
                  ],
                );
              },
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
      listener: (context, state) {},
    );
  }
}
