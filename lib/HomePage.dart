// import 'package:flutter/material.dart';
// import 'package:fluro/fluro.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:io';

// class HomePage extends StatelessWidget {
//   final FluroRouter? router;

//   HomePage({super.key, required this.router});

//   initState() {
//     // super.initState();
//     checkConnectivity();
//     getDeviceInfo();
//   }

//   Future<void> checkConnectivity() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     print('当前使用的是移动网络');
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     print('当前使用的是Wi-Fi');
//   } else if (connectivityResult == ConnectivityResult.none) {
//     print('当前没有网络连接');
//   }
// }

// Future<void> getDeviceInfo() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     print('设备型号: ${androidInfo.model}');
//     print('设备品牌: ${androidInfo.manufacturer}');
//     print('系统版本: ${androidInfo.version.release}');
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     print('设备型号: ${iosInfo.utsname.machine}');
//     print('系统版本: ${iosInfo.systemVersion}');
//   }
// }

//   // HomePage(this.router);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/login");
//               },
//               child: Text('Go to login Page'),
//             ),
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/register");
//               },
//               child: Text('Go to register Page'),
//             ),
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/second");
//               },
//               child: Text('Go to Second Page'),
//             ),
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/camera");
//               },
//               child: Text('Go to camera Page'),
//             ),
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 // Navigator.pushNamed(
//                 //   context,
//                 //   '/profile/56',
//                 // );
//                 // final router = FluroRouter();
//                 // if(router!=null)  {
//                 //   router?.navigateTo(
//                 //     context,
//                 //     '/profile/123567',
//                 //     transition: TransitionType.fadeIn,
//                 //   );
//                 // }
//                 Navigator.pushNamed(
//                   context,
//                   '/profile/567',
//                 );
//               },
//               child: Text('Go to ProfileScreen Page'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/register.dart';
import 'dart:io';
import 'battery_level_page.dart';
import 'post_page.dart';
import 'package:camera/camera.dart';
import 'camera.dart';
import 'Animation.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:fluttertoast/fluttertoast.dart';
import 'iconfont.dart'; // 导入图标映射文件

class HomePage extends StatefulWidget {
  final FluroRouter router;

  HomePage({required this.router});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  List<Calendar>? _calendars;
  Calendar? _selectedCalendar;
  dynamic firstCamera;
  @override
  void initState() {
    super.initState();
    _retrieveCalendars();
    // getDeviceInfo();
    checkConnectivity();

    getCamera();

    // WidgetsFlutterBinding.ensureInitialized(); // 确保Flutter初始化
    // final cameras = await availableCameras(); // 获取可用摄像头
    // firstCamera = cameras.first; // 使用第一个摄像头

    // setState(() {
    //  WidgetsFlutterBinding.ensureInitialized(); // 确保Flutter初始化
    // final cameras = await availableCameras(); // 获取可用摄像头

    //     firstCamera = cameras.first; // 使用第一个摄像头

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Page'),
      // ),
      // appBar: AppTheme.of(context)!.appBar as PreferredSizeWidget?, // 获取全局导航栏
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/second");
              },
              child: Text('Go to Second Page'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.router.navigateTo(
                  context,
                  '/profile/123',
                  transition: TransitionType.inFromTop,
                  transitionDuration: Duration(milliseconds: 30),
                );
              },
              child: Text('Go to ProfileScreen Page'),
            ),
            ElevatedButton(
              onPressed: () async {
                await checkConnectivity();
              },
              child: Text('Check Connectivity'),
            ),
            ElevatedButton(
              onPressed: () async {
                await getDeviceInfo();
              },
              child: Text('Get Device Info'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage()),
                );
              },
              child: Text('发朋友圈'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('注册'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(camera: firstCamera),
                  ),
                );
              },
              child: Text('拍照'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimationPage(),
                  ),
                );
              },
              child: Text('动画'),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _addEventToCalendar,
                child: Text('添加购物提醒'),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   IconFont.shopping_cart,
                      //   size: 20.0,
                      //   color: Colors.red,
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BatteryLevelPage(),
                            ),
                          );
                        },
                        child: Text('原生获取电量'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BatteryLevelPage(),
                  ),
                );
              },
              child: Text('高德相关'),
            ),
            Icon(IconFont.user,
                size: 30.0, color: const Color.fromARGB(255, 199, 135, 130)),
          ],
        ),
      ),
    );
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('当前使用移动网络');
      Fluttertoast.showToast(
          msg: "当前使用移动网络",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('当前使用WiFi');
      Fluttertoast.showToast(
          msg: "当前使用WiFi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (connectivityResult == ConnectivityResult.none) {
      print('当前没有网络连接');
      Fluttertoast.showToast(
          msg: "当前没有网络连接",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('设备型号: ${androidInfo.model}');
      print('设备品牌: ${androidInfo.manufacturer}');
      print('系统版本: ${androidInfo.version.release}');
      Fluttertoast.showToast(
          msg: "设备型号: ${androidInfo.model}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('设备型号: ${iosInfo.utsname.machine}');
      print('系统版本: ${iosInfo.systemVersion}');
    }
  }

  Future<void> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized(); // 确保Flutter初始化
    final cameras = await availableCameras(); // 获取可用摄像头
    firstCamera = cameras.first; // 使用第一个摄像头
  }

  Future<void> _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
          return;
        }
      }

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult.data;
        if (_calendars != null && _calendars!.isNotEmpty) {
          _selectedCalendar = _calendars!.first;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addEventToCalendar() async {
    if (_selectedCalendar == null) {
      return;
    }

    tz.initializeTimeZones(); // 初始化时区
    final location = tz.local; // 获取本地时区

    final now = tz.TZDateTime.now(location);
    final event = Event(
      _selectedCalendar!.id,
      title: '购物提醒',
      description: '这是一个购物提醒',
      start: now.add(Duration(minutes: 10)),
      end: now.add(Duration(minutes: 20)),
    );

    await _deviceCalendarPlugin.createOrUpdateEvent(event);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已添加购物提醒到日历')),
    );
  }
}
