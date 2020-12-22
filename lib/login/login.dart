import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:with_u/home_screen.dart';
import 'package:with_u/login/login_screen.dart';
import 'package:with_u/resources/Colours.dart';
import 'package:with_u/resources/Styles.dart';
import 'package:with_u/utils/SharedpreferencesUtils.dart';
import './delayed_animation.dart';
import '../resources/Strings.dart';

class InitLogInScreen extends StatefulWidget {
  @override
  _InitLogInScreenState createState() => new _InitLogInScreenState();
}

class _InitLogInScreenState extends State<InitLogInScreen> {
  startTime() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      NoAnimRouter(LogIn()),
      // MaterialPageRoute<dynamic>(
      //   builder: (BuildContext context) => LogIn(),
      // ),
          (route) => route == null,
    );
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'AvatarGlow',
            child: AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.white24,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 2),
              startDelay: Duration(seconds: 1),
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: FlutterLogo(
                      size: 50.0,
                    ),
                    radius: 50.0,
                  )),
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );;
  }
}

//无动画
class NoAnimRouter<T> extends PageRouteBuilder<T> {
  final Widget page;
  NoAnimRouter(this.page)
      : super(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 700),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) => child);
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin {
  final int delayedAmount = -100;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: Colours.welcomeBGColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'AvatarGlow',
                child: AvatarGlow(
                  endRadius: 90,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: FlutterLogo(
                          size: 50.0,
                        ),
                        radius: 50.0,
                      )),
                ),
              ),
              DelayedAnimation(
                child: Text(Strings.welcomeWords1, style: Styles.welcomeWords1),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(Strings.welcomeWords2, style: Styles.welcomeWords1),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Text(
                  Strings.welcomeWords5,
                  style: Styles.welcomeWords2,
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  Strings.welcomeWords6,
                  style: Styles.welcomeWords2,
                ),
                delay: delayedAmount + 3000,
              ),
              SizedBox(
                height: 100.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(
                height: 25.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                    // Navigator.push<dynamic>(
                    //   context,
                    //   MaterialPageRoute<dynamic>(
                    //     builder: (BuildContext context) => LoginScreen(),
                    //   ),
                    // );
                  },
                  child: Text(Strings.welcomeWords4.toUpperCase(),
                      style: Styles.welcomeWords3),
                ),
                delay: delayedAmount + 4500,
              ),
            ],
          ),
        ));
  }

  Widget get _animatedButtonUI => GestureDetector(
        child: Container(
          height: 60,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              Strings.welcomeWords3,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8185E2),
              ),
            ),
          ),
        ),
        onTap: () {
          SharedPreferencesUtils.savePreference(
              context, "LogInToken", "LogInSucess");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
          // Navigator.push<dynamic>(
          //   context,
          //   MaterialPageRoute<dynamic>(
          //     builder: (BuildContext context) => LoginScreen(),
          //   ),
          // );
        },
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
