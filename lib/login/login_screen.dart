import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:with_u/resources/Colours.dart';
import 'package:with_u/resources/theme.dart';

import '../home_screen.dart';

const users = const {
  '804075486@qq.com': '12345',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return '用户名不存在';
      }
      if (users[data.name] != data.password) {
        return '密码不匹配';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return '用户名不存在';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Gliese 667C',
      // logo: 'lib/images/logo.jpg',
      onLogin: _authUser,
      onSignup: _authUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      theme: LoginTheme(
        primaryColor: Colours.welcomeBGColor,
        accentColor: Colours.welcomeBGColor,
        titleStyle: TextStyle(
          color: AppTheme.nearlyWhite,
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colours.welcomeBGColor,
        ),
      ),
      messages: LoginMessages(
        usernameHint: '用户名',
        passwordHint: '密码',
        confirmPasswordHint: '确认密码',
        forgotPasswordButton: '忘记了咩',
        loginButton: '登陆星球',
        signupButton: '注册居民证',
        recoverPasswordButton: '发送',
        recoverPasswordIntro: '重置密码',
        recoverPasswordDescription:
        '我们将发送一份确认码到您的邮箱',
        goBackButton: '返回',
        confirmPasswordError: '密码不匹配！',
        recoverPasswordSuccess: '祝贺！密码重置成功',
      )
      ,
    );
  }
}