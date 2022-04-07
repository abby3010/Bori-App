// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:bori_app/view/screens/MainActivity.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController? _fadeAnimationController;
  AnimationController? _slideAnimationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds:1450),
    );

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(_slideAnimationController!);

    _fadeAnimation = CurvedAnimation(
      parent: _fadeAnimationController!,
      curve: Curves.easeIn,
    );

    Future.delayed(
      Duration(milliseconds: 3710),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainActivity()),
        );
      },
    );
    _delayAnimation();
    super.initState();
  }

  Future<void> _delayAnimation() async {
    try {
      await _slideAnimationController!.forward().orCancel;
      await _fadeAnimationController!.forward().orCancel;
    } on TickerCanceled {
      //
    }
  }

  @override
  void dispose() {
    _slideAnimationController!.dispose();
    _fadeAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(245, 227, 204, 1),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            FadeTransition(
              opacity: _fadeAnimation!,
              child: Image.asset(
                'assets/images/app-splash-logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SlideTransition(
                        position: _slideAnimation!,
                        child: Image.asset(
                          'assets/images/app-splash-bottom.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Center(
                          child: FadeTransition(
                            opacity: _fadeAnimation!,
                            child: Text(
                              "The Bhandarkar Oriental\nResearch Institute",
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
