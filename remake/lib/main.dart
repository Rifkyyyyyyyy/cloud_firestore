import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remake/common/style/theme/theme.dart';
import 'package:remake/data/datasource/notifications.dart';
import 'package:remake/firebase_options.dart';
import 'package:remake/injection.dart';
import 'package:remake/observer.dart';
import 'package:remake/presentation/bloc/export.dart';
import 'package:remake/presentation/config/route.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationsServices().initNotification();
  await injectionInit(); 

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => ls()..add(GetTasksEvents()),
      child: MaterialApp.router(
        theme: themeData(),
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter(),
        title: 'To-Do App',
      ),
    );
  }
}
