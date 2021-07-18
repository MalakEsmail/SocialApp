import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/my_bloc_observer.dart';
import 'package:socialapp/network/local.dart';
import 'package:socialapp/screens/home.dart';
import 'package:socialapp/screens/loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  // Chech widget whitch to open first
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: startWidget,
      ),
    );
  }
}
