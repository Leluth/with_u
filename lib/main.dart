import 'dart:io';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:with_u/home_screen.dart';
import 'package:with_u/resources/Colours.dart';
import 'package:with_u/resources/theme.dart';
import 'package:with_u/utils/SharedpreferencesUtils.dart';
import 'login/login.dart';
import 'modles/mymodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CloudBaseCore core = CloudBaseCore.init({
    // 填写您的云开发 env
    'env': 'gliese667c-3gniwi3a69836d7b',
    // 填写您的移动应用安全来源凭证
    // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
    'appAccess': {
      // 凭证
      'key': 'ac269b528c8b51e3ea7ff6c523c2c755',
      // 版本
      'version': '1'
    },
    // 请求超时时间（选填）
    'timeout': 3000
  });
  // 获取登录对象
  CloudBaseAuth auth = CloudBaseAuth(core);
  // 获取登录状态
  CloudBaseAuthState authState = await auth.getAuthState();
// 唤起匿名登录
  if (authState == null) {
    await auth.signInAnonymously().then((success) {
      // 登录成功
      print('登录成功');
    }).catchError((err) {
      // 登录失败
      print('登录失败');
    });
  }
  if (authState != null) {
    await auth.getUserInfo().then((userInfo) {
      // 获取用户信息成功
      print('获取用户信息成功:'+userInfo.toString());
    }).catchError((err) {
      // 获取用户信息失败
      print('获取用户信息失败');
    });
  }
  // 云函数
  // CloudBaseFunction cloudBaseFunction = CloudBaseFunction(core);
  // // 请求参数
  // Map<String, dynamic> data = {'a': 1, 'b': 2};
  // CloudBaseResponse res = await cloudBaseFunction.callFunction('sum', data);
  // print(res.data);
  // 云存储
  // CloudBaseStorage storage = CloudBaseStorage(core);
  // final directory = await getApplicationDocumentsDirectory();
  // String path = directory.path;
  // final file = new File('$path/test.txt');
  // IOSink slink = file.openWrite(mode: FileMode.append);
  // slink.write('Hi\n');
  // slink.close();
  // await storage.uploadFile(
  //     cloudPath: 'flutter/test.txt',
  //     filePath: '$path/test.txt',
  //     onProcess: (int count, int total) {
  //       // 当前进度/总进度
  //       print('上传进度'+count.toString()+'/'+total.toString());
  //     }
  // );

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
