export 'package:flutter/material.dart';
export 'dart:convert';
export 'package:flutter/services.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';

export 'package:dfmdsapp/components/pagesComponents/home.dart';
export 'package:dfmdsapp/components/pagesComponents/exeption.dart';

export 'package:dfmdsapp/components/form.dart';
export 'package:dfmdsapp/components/raisedButton.dart';
export 'package:dfmdsapp/components/appBar.dart';
export 'package:dfmdsapp/components/slide_button.dart';
export 'package:dfmdsapp/components/remove_btn.dart';
export 'package:dfmdsapp/components/card.dart';
export 'package:dfmdsapp/components/wrap_home.dart';
export 'package:dfmdsapp/components/page_head.dart';
export 'package:dfmdsapp/components/slide_button.dart';
export 'package:dfmdsapp/components/sliver_tab_bar.dart';

export 'package:dfmdsapp/assets/iconfont/IconFont.dart';

export 'package:dfmdsapp/api/api/index.dart';

export 'package:dfmdsapp/utils/storage.dart';
export 'package:dfmdsapp/utils/pxunit.dart';
export 'package:dfmdsapp/utils/toast.dart';

import 'dart:convert';

int getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  hexColor = hexColor.replaceAll('0X', '');
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return int.parse(hexColor, radix: 16);
}

class MapUtil {
  static mapNullToEmpty(Map map) {
    map.forEach((key, value) {
      if (value == null) {
        map[key] = '';
      }
      if (value.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        mapNullToEmpty(value);
      }
    });
    return map;
  }

  static listNullToEmpty(List list) {
    list.forEach((element) {
      element = mapNullToEmpty(element);
    });
    return list;
  }
}
