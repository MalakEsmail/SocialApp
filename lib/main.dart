import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/my_bloc_observer.dart';
import 'package:socialapp/network/local.dart';
import 'package:socialapp/screens/home.dart';
import 'package:socialapp/screens/loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> callBGMessage(RemoteMessage message) {
  print('on message from bg');
  showToast(text: 'on message from bg', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  // notificion
  var appToken = await FirebaseMessaging.instance.getToken();
  print('app token = $appToken');
  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print(' on messaging ');
    print(event.data.toString());
  });
  // when click on notification and open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(' on messaging opened app');
    print(event.data.toString());
  });
  // on bg notification
  FirebaseMessaging.onBackgroundMessage(callBGMessage);
  // Check widget which to open first
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
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
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
