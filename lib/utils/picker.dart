import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:date_format/date_format.dart';

const double kPickerHeight = 216.0;
const double kItemHeight = 40.0;
const Color kBtnColor = Color(0xFF323232); //50
const Color kTitleColor = Color(0xFF787878); //120
const double kTextFontSize = 17.0;

typedef StringClickCallback = void Function(Object selectStr);
enum DateType {
  YMD, // y, m, d
  YM, // y ,m
  YMD_HM, // y, m, d, hh, mm
  YMD_AP_HM, // y, m, d, ap, hh, mm
}

class PickerTool {
  static void showOneRow<T>(
    BuildContext context, {
    @required List<T> data,
    String title,
    @required String label,
    @required String value,
    String label1 = '',
    String label2 = '',
    String selectVal,
    PickerDataAdapter adapter,
    @required clickCallBack,
  }) {
    var selectIndex = 0;
    openModalPicker(context,
        adapter: PickerDataAdapter(
            data: data.asMap().keys.map((index) {
              Map<dynamic, dynamic> it = data[index] as Map;
              if (it[value].toString() == selectVal) {
                selectIndex = index;
              }
              return PickerItem(
                text: Text(label1 + it[label].toString() + label2),
                value: it[value].toString(),
              );
            }).toList(),
            isArray: false), clickCallBack: (Picker picker, value) {
      clickCallBack(data[value[0]]);
    }, selecteds: [selectIndex], title: title);
  }

  static void showDatePicker(
    BuildContext context, {
    DateType dateType,
    String valueFormat,
    String title,
    DateTime maxValue,
    DateTime minValue,
    String value,
    DateTimePickerAdapter adapter,
    @required clickCallback,
  }) {
    int timeType;
    if (dateType == DateType.YM) {
      timeType = PickerDateTimeType.kYM;
    } else if (dateType == DateType.YMD_HM) {
      timeType = PickerDateTimeType.kYMDHM;
    } else if (dateType == DateType.YMD_AP_HM) {
      timeType = PickerDateTimeType.kYMD_AP_HM;
    } else {
      timeType = PickerDateTimeType.kYMD;
    }
    openModalPicker(context,
        adapter: adapter ??
            DateTimePickerAdapter(
              type: timeType,
              isNumberMonth: true,
              maxValue: maxValue,
              minValue: minValue,
              value: (value == '' ? DateTime.now() : DateTime.parse(value)),
              yearSuffix: "年",
              monthSuffix: "月",
              daySuffix: "日",
              strAMPM: const ["上午", "下午"],
            ),
        title: title, clickCallBack: (Picker picker, List<int> selecteds) {
      var time = (picker.adapter as DateTimePickerAdapter).value;
      List<String> valueFormatArr = [];
      RegExp reg = new RegExp(r"(.)\1*");
      Iterable<Match> a = reg.allMatches(valueFormat);
      a.forEach((element) {
        String match = element.group(0);
        valueFormatArr.add(match);
      });
      var timeStr = formatDate(time, valueFormatArr);
      clickCallback(timeStr);
    });
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
