import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'router/index.dart';

class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        navigatorKey: Router.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

//typedef _ClickCallBack = void Function(int selectIndex, String selectText);
//
//List dataArr = [
//  {"text": "发起群聊", "icons": Icons.home},
//  {"text": "添加朋友", "icons": "lib/assets/images/potDetail.jpg"},
//  {"text": "扫一扫", "icons": "lib/assets/images/potDetail.jpg"},
//  {"text": "收付款", "icons": "lib/assets/images/potDetail.jpg"},
//];
//
//Color _bgColor = Color(0xFF2D2D2D);
//double _fontSize = 16.0;
//double _cellHeight = 50.0;
//double _imgWH = 22.0;
////显示带线带背景 pop
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//
//  @override
//  Widget build(BuildContext context, {bool isShowBg = false, _ClickCallBack clickCallback}) {
//    //声明不同颜色的分割线
//    return MaterialApp(
//        home: Scaffold(
//          body: Scrollbar(
//            child: Center(
//                child: ListView.separated(
//                  itemCount: 4,
//                  padding: const EdgeInsets.all(0.0),
//                  physics: const NeverScrollableScrollPhysics(),
//                  //判断奇偶数进行分割线颜色处理
//                  itemBuilder: (BuildContext context, int index){
//                    return Material(
//                        color: _bgColor,
//                        child: InkWell(
//                            onTap: () {
//                              print('1');
//                            },
//                            child: Container(
//                              height: _cellHeight,
//                              child: Row(
//                                children: <Widget>[
//                                  SizedBox(width: 25),
//                                  Icon(Icons.home, color: Colors.white),
////                                  Icon(dataArr[index]['icons'], color: Colors.white),
//                                  SizedBox(width: 12),
//                                  Text(dataArr[index]['text'],
//                                    style: TextStyle(color: Colors.white, fontSize: _fontSize)
//                                  )
//                                ],
//                              ),
//                            )));
//                  },
//                  separatorBuilder: (context, index) {
//                    return Divider(
//                      height: .1,
//                      indent: 50,
//                      endIndent: 0,
//                      color: Color(0xFFE6E6E6),
//                    );
//                  },
//                )
//            ),
//          ),
//        )
//    );
//  }
//}
//
