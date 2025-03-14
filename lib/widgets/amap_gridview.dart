import 'package:flutter/material.dart';

class AMapGradView extends StatefulWidget {
  ///子控件列表
  final List<Widget> childrenWidgets;

  ///一行的数量
  final int crossAxisCount;

  ///宽高比
  final double childAspectRatio;

  // AMapGradView(
  //     { Key key,
  //      this.crossAxisCount,
  //      this.childAspectRatio,
  //      this.childrenWidgets})
  //     : super(key: key);


  AMapGradView({
    Key? key,
    this.crossAxisCount = 2, // 提供默认值
    this.childAspectRatio = 4.0, // 提供默认值
    this.childrenWidgets = const [], // 提供默认值
  }) : super(key: key);


  
  @override
  _GradViewState createState() => _GradViewState();
}

class _GradViewState extends State<AMapGradView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        physics: new NeverScrollableScrollPhysics(),
        //水平子Widget之间间距
        crossAxisSpacing: 1.0,
        //垂直子Widget之间间距
        mainAxisSpacing: 0.5,
        //一行的Widget数量
        crossAxisCount: widget.crossAxisCount ?? 2,
        //宽高比
        childAspectRatio: widget.childAspectRatio ?? 4,
        children: widget.childrenWidgets,
        shrinkWrap: true);
  }
}
