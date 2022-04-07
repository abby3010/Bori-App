// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/SplashScreen.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyA0ZoajGdNrKiUfG7XBgbOIhoCeA7EWym4",
      appId: "1:735698014794:ios:8e906f8172a55533ebccb3",
      messagingSenderId: "Your Sender id found in Firebase",
      projectId: "bori-app",
    ));
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const BoriApp());
  });
}

class BoriApp extends StatelessWidget {
  const BoriApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BookingViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BORI',
        theme: ThemeData(
          appBarTheme: AppBarTheme(centerTitle: true),
          primarySwatch: AppTheme.AppBarTheme,
          fontFamily: 'SF_Pro',
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 19.2),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
        },
      ),
    );
  }
}
