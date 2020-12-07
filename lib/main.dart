import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:with_u/home_screen.dart';
import 'package:with_u/resources/Colours.dart';
import 'package:with_u/resources/theme.dart';
import 'package:with_u/utils/SharedpreferencesUtils.dart';
import 'login/login.dart';
import 'modles/mymodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => initializeDateFormatting().then((_) => runApp(MyApp())));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyModel>(
          create: (_) => MyModel(),
        ),
      ],
      child: MaterialApp(
        title: 'With U',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ActivePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return new Scaffold(
      body:  new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset('lib/images/area1.png');
        },
        itemCount: 10,
        itemWidth: 300.0,
        layout: SwiperLayout.STACK,
      )
    );
  }
}

class ActivePage extends StatefulWidget {
  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  AnimationController _controller;
  var logInState;
  double _scale;
  Future<String> _logInState;

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
    _logInState = checkLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: Colours.welcomeBGColor,
        body: FutureBuilder(
          future: _logInState,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.done) {
              // print(snap.data);
              if (snap.data == "NotLog") {
                return Stack(
                  children: <Widget>[
                    LogIn(),
                  ],
                );
              } else {
                return Stack(
                  children: <Widget>[
                    HomeScreen(),
                  ],
                );
              }
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AvatarGlow(
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
                    SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              );
            }
            if (snap.hasError) {
              return Text('Error');
            }
            return Container();
          },
        ));
  }

  Future<String> checkLogIn() async {
    await Future.delayed(Duration(seconds: 3));
    String logInToken = await (SharedPreferencesUtils.getPreference(
        context, "LogInToken", 'NotLog')) as String;
    return logInToken;
  }
}
