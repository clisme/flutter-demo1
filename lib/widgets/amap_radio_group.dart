// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_application_1/widgets/amap_gridview.dart';
import 'package:flutter/material.dart';

class AMapRadioGroup<T> extends StatefulWidget {
  final String groupLabel;
  final T groupValue;
  final Map<String, T> radioValueMap;
  final ValueChanged<T> onChanged;
  
  AMapRadioGroup(
      { Key? key,
       this.groupLabel='',
       required this.groupValue,
       required this.radioValueMap,
       required this.onChanged})
      : super(key: key);

  @override
  _AMapRadioGroupState createState() => _AMapRadioGroupState();
}

class _AMapRadioGroupState extends State<AMapRadioGroup> {
  dynamic _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupValue ?? null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> radioList = [];
    _groupValue = widget.groupValue ?? null;
    Widget _myRadio(String label, dynamic radioValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          Radio(
            value: radioValue,
            groupValue: _groupValue,
            onChanged: (value) {
              setState(() {
                _groupValue = value;
              });
              if (null != widget.onChanged) {
                widget.onChanged(value);
              }
            },
          ),
        ],
      );
    }

    if (widget.radioValueMap != null) {
      if (radioList == null) {
        radioList = [];
      }
      widget.radioValueMap.forEach((key, value) {
        radioList.add(_myRadio(key, value));
      });
    }
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.groupLabel != null)
            Text(widget.groupLabel,
                style: TextStyle(fontWeight: FontWeight.w600)),
          // widget.groupLabel != null
          //     ? Text(widget.groupLabel,
          //         style: TextStyle(fontWeight: FontWeight.w600))
          //     : null,
          Container(
            padding: EdgeInsets.only(left: 10),
            // child: AMapGradView(
            //   childrenWidgets: radioList,
            // ),
            child: AMapGradView(
              key: UniqueKey(), // 添加 key 参数
              crossAxisCount: 2, // 添加 crossAxisCount 参数
              childAspectRatio: 4 / 1, // 添加 childAspectRatio 参数
              childrenWidgets: radioList,
            ),
          ),
        ],
      ),
    );
  }
}
