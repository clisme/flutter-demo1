import 'package:fluro/fluro.dart';
import 'package:flutter_application_1/HomePage.dart';
import 'package:flutter_application_1/ProfileScreen.dart';
import 'package:flutter_application_1/SecondPage.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/register.dart';
// import 'package:flutter_application_1/camera.dart';
import 'package:flutter_application_1/UserStorage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.define(
      "/",
      handler: Handler(
        handlerFunc: (context, parameters) => HomePage(router: router),
      ),
    );
    router.define(
      "/second",
      handler: Handler(handlerFunc: (context, parameters) => SecondPage()),
    );
    router.define(
      "/login",
      handler: Handler(handlerFunc: (context, parameters) => LoginPage()),
    );
    router.define(
      "/register",
      handler: Handler(handlerFunc: (context, parameters) => RegisterPage()),
    );
    //  router.define(
    //   "/camera",
    //   handler: Handler(handlerFunc: (context, parameters) => CameraScreen()),
    // );
    router.define(
      "/profile/:id",
      handler: Handler(
        handlerFunc: (context, parameters) {
          final id = parameters['id']?.first;
          return ProfileScreenWrapper(userId: id);
          //  bool c = await UserStorage.islogin();
          // print(c);
          // final id = parameters['id']?.first; // 将id声明移到if块外
          // if ( c) {
          //   return ProfileScreen(userId: id);
          // } else {
          //   return ProfileScreen(userId: id);
          // }
        },
      ),
    );
  }
}

// 1. 使用FutureBuilder或StreamBuilder
// 将ProfileScreen包装在一个FutureBuilder或StreamBuilder中，以便在异步操作完成后构建页面。
class ProfileScreenWrapper extends StatelessWidget {
  final String? userId;

  ProfileScreenWrapper({this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: UserStorage.islogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 显示加载指示器
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // 显示错误信息
        } else {
          final isLoggedIn = snapshot.data ?? false;
          if (isLoggedIn) {
            return ProfileScreen(userId: userId);
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('请先注册账号！')),
            // );

            Fluttertoast.showToast(
                msg: "请先登录！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            // 未登录时重定向到登录页面
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, '/login');
            });
            return Container(); // 返回一个空容器
          }
        }
      },
    );
  }
}
