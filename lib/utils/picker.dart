import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_picker/Picker.dart';

const double kPickerHeight = 216.0;
const double kItemHeight = 40.0;
const Color kBtnColor = Color(0xFF323232); //50
const Color kTitleColor = Color(0xFF787878); //120
const double kTextFontSize = 17.0;

typedef StringClickCallback = void Function(Object selectStr);

class PickerTool {
  static void showOneRow<T>(
    BuildContext context, {
    @required List<T> data,
    String title,
    @required String label,
    @required String value,
    String selectVal,
    PickerDataAdapter adapter,
    @required clickCallBack,
  }) {
    var selectIndex = 0;
    openModalPicker(context,
        adapter: PickerDataAdapter(
            data: data.asMap().keys.map((index) {
              Map<dynamic, dynamic> it = data[index] as Map;
              if (it[label] == selectVal) {
                selectIndex = index;
              }
              return PickerItem(
                text: Text(it[label]),
                value: it[value],
              );
            }).toList(),
            isArray: false), clickCallBack: (Picker picker, value) {
      clickCallBack(data[value[0]]);
    }, selecteds: [selectIndex], title: title);
  }

  static void openModalPicker(
    BuildContext context, {
    @required PickerAdapter adapter,
    String title,
    List<int> selecteds,
    @required PickerConfirmCallback clickCallBack,
  }) {
    new Picker(
            adapter: adapter,
            title: new Text(title ?? "请选择",
                style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
            selecteds: selecteds,
            cancelText: '取消',
            confirmText: '确定',
            cancelTextStyle:
                TextStyle(color: kBtnColor, fontSize: kTextFontSize),
            confirmTextStyle:
                TextStyle(color: kBtnColor, fontSize: kTextFontSize),
            textAlign: TextAlign.right,
            itemExtent: kItemHeight,
            height: kPickerHeight,
            selectedTextStyle: TextStyle(color: Colors.black),
            onConfirm: clickCallBack)
        .showModal(context);
  }
}
