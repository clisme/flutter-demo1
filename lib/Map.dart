// // import 'package:amap_flutter_map/amap_flutter_map.dart';
// // import 'package:flutter/material.dart';
// // import 'package:amap_flutter_base/amap_flutter_base.dart';

// // class MapPage extends StatelessWidget {
// //   final AMapController _mapController = AMapController();


 
// //   void onMapCreated(AMapController controller) {
// //     setState(() {
// //       _mapController = controller;
// //       getApprovalNumber();
// //     });
// //   }

// //   /// 获取审图号
// //   void getApprovalNumber() async {
// //     //普通地图审图号
// //     String mapContentApprovalNumber =
// //         await _mapController?.getMapContentApprovalNumber();
// //     //卫星地图审图号
// //     String satelliteImageApprovalNumber =
// //         await _mapController?.getSatelliteImageApprovalNumber();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     ///使用默认属性创建一个地图
// //     final AMapWidget map = AMapWidget(
// //       apiKey: ConstConfig.amapApiKeys,
// //       onMapCreated: onMapCreated,
// //     );
// //     return Container(
// //       height: MediaQuery.of(context).size.height,
// //       width: MediaQuery.of(context).size.width,
// //       child: map,
// //     );
// //   }

 

// //   // Widget build(BuildContext context) {
// //   //   return Scaffold(
// //   //     body: AMapWidget(
// //   //       onMapCreated: (controller) {
// //   //         _mapController = controller;
// //   //       },
// //   //       // 初始地图配置
// //   //       initialCameraPosition: CameraPosition(
// //   //         target: LatLng(39.909187, 116.397451), // 北京天安门
// //   //         zoom: 15,
// //   //       ),
// //   //       // 地图类型：normal(标准), satellite(卫星), night(夜间)
// //   //       mapType: MapType.normal,
// //   //       // 是否显示缩放控件
// //   //       zoomControlsEnabled: true,
// //   //       // 是否显示指南针
// //   //       compassEnabled: true,
// //   //     ),
// //   //   );
// //   // }
// // }







// import 'package:amap_flutter_map/amap_flutter_map.dart';
// import 'package:flutter/material.dart';
// import 'package:amap_flutter_base/amap_flutter_base.dart';

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   AMapController? _mapController;

//   void onMapCreated(AMapController controller) {
//     setState(() {
//       _mapController = controller;
//       getApprovalNumber();
//     });
//   }

//   /// 获取审图号
//   void getApprovalNumber() async {
//     if (_mapController != null) {
//       // 普通地图审图号
//       String mapContentApprovalNumber =
//           await _mapController!.getMapContentApprovalNumber();
//       // 卫星地图审图号
//       String satelliteImageApprovalNumber =
//           await _mapController!.getSatelliteImageApprovalNumber();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// 使用默认属性创建一个地图
//     final AMapWidget map = AMapWidget(
//       apiKey: ConstConfig.amapApiKeys,
//       onMapCreated: onMapCreated,
//     );
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: map,
//     );
//   }
// }