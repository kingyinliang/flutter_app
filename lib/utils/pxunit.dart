import 'package:flutter/material.dart';

MediaQueryData mediaQuery =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window);
var w = mediaQuery.size.width; //屏幕宽度
var h = mediaQuery.size.height; //屏幕高度
var scale = mediaQuery.devicePixelRatio; //每一个逻辑像素包含多少个原始像素
var statusBar = mediaQuery.padding.top; //状态栏高度

double unit = w / 375.0;

double pxUnit(double px) {
  return px * unit;
}
