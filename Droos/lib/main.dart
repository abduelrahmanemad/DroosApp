import 'package:bloc/bloc.dart';
import 'package:droos/layout/layout.dart';
import 'package:droos/modules/login.dart';
import 'package:droos/modules/register.dart';
import 'package:droos/shared/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';
import 'modules/edit_profile.dart';
import 'observer/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize();
  BlocOverrides.runZoned(()async {

    runApp(const MyApp());
  },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.blue),
                actionsIconTheme: IconThemeData(color: Colors.blue),
                backgroundColor: Colors.white,

              ),
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff6688FF),
              secondary: const Color(0xff6688FF),
            ),

          ),
          debugShowCheckedModeBanner: false,
          home: const Login(),
        );
      },
      designSize: const Size(360, 640),
    );
  }
}

