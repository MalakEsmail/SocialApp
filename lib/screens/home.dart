import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/screens/new_post_screen.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
          ),
          body: cubit.pages[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.blue,
              selectedItemColor: Colors.blue,
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.post_add_outlined), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
    );
  }
}
/*

ConditionalBuilder(
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
            )
 */
