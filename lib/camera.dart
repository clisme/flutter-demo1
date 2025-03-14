// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// List<CameraDescription> cameras = [];

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CameraScreen(),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     _controller = CameraController(
//       cameras[0], // 使用第一个摄像头
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller!.initialize();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('拍照')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller!);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _takePicture,
//         child: Icon(Icons.camera),
//       ),
//     );
//   }

//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller!.takePicture();

//       // 显示拍照结果
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DisplayPictureScreen(imagePath: image.path),
//         ),
//       );
//     } catch (e) {
//       print("拍照失败: $e");
//     }
//   }
// }

// // 创建一个页面来显示拍摄的照片：
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   DisplayPictureScreen({required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('拍摄的照片')),
//       body: Center(
//         child: Image.file(File(imagePath)),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:permission_handler/permission_handler.dart';

// List<CameraDescription> cameras = [];

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CameraScreen(),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     requestCameraPermission().then((_) {
//       _initializeCamera();
//     });
//   }

//   Future<void> requestCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       await Permission.camera.request();
//     }
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       if (cameras.isEmpty) {
//         print("未找到可用的摄像头");
//         return;
//       }
//       _controller = CameraController(
//         cameras[0], // 使用第一个摄像头
//         ResolutionPreset.medium,
//       );
//       _initializeControllerFuture = _controller!.initialize();
//       setState(() {});
//     } catch (e) {
//       print("摄像头初始化失败: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('拍照')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(child: Text("摄像头初始化失败: ${snapshot.error}"));
//             }
//             return CameraPreview(_controller!);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _takePicture,
//         child: Icon(Icons.camera),
//       ),
//     );
//   }

//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller!.takePicture();

//       // 显示拍照结果
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DisplayPictureScreen(imagePath: image.path),
//         ),
//       );
//     } catch (e) {
//       print("拍照失败: $e");
//     }
//   }
// }

// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   DisplayPictureScreen({required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('拍摄的照片')),
//       body: Center(
//         child: Image.file(File(imagePath)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'dart:io';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera, // 传入摄像头描述
      ResolutionPreset.medium, // 设置分辨率
    );

    _initializeControllerFuture = _controller.initialize(); // 初始化摄像头
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放摄像头资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller); // 显示摄像头预览
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture(); // 拍摄照片
            print('Image saved to ${image.path}'); // 打印照片路径
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     try {
      //       await _initializeControllerFuture;
      //       final image = await _controller.takePicture(); // 拍摄照片

      //       // 获取应用程序的文档目录
      //       final directory = await getApplicationDocumentsDirectory();
      //       final imagePath = '${directory.path}/${DateTime.now()}.png';

      //       // 将照片保存到应用程序的文档目录
      //       final imageFile = File(image.path);
      //       await imageFile.copy(imagePath);

      //       // 将照片保存到手机相册
      //       await GallerySaver.saveImage(imagePath);

      //       print('Image saved to ${image.path}'); // 打印照片路径
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('照片已保存到相册')),
      //       );
      //     } catch (e) {
      //       print(e);
      //     }
      //   },
      //   child: Icon(Icons.camera),
      // ),
    );
  }
}
