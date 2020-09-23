import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dfmdsapp/main.dart';

import './env.dart';
import './msg.dart';

class WebSocketManager {
  WebSocketManager._();

  static WebSocketManager _manager;
  static WebSocket webSocket;
  static Stream mStream;
  static Future<WebSocket> future;
  static bool connectState = false;

  factory WebSocketManager() {
    if (_manager == null) {
      _manager = new WebSocketManager._();
    }
    return _manager;
  }

  static initSocket(String userId) async {
    if (connectState == false) {
      print('初始化socket');
      String path = HostAddress.SOCKET_API + userId;
      future = WebSocket.connect(path);
      future.then((socket) {
        connectState = true;
        print('================socket初始化完成连接================');
        webSocket = socket;
        mStream = socket.asBroadcastStream();
        mStream.listen((event) {
          print('================服务器发来的================');
          event = jsonDecode(event);

          Router.navigatorKey.currentState
              .push(DialogRouter(MessageDialog(data: event)));
          Future.delayed(
            Duration(milliseconds: 2000),
            () {
              Router.navigatorKey.currentState.pop();
            },
          );
          EventBusUtil.getInstance().fire(MsgEvent(event));
        });
      }).catchError((onError) {
        print('================socket初始化失败================');
        print(onError);
        Future.delayed(Duration(seconds: 5), () {
          initSocket(userId);
        });
      });
    }
  }

  static void dispos() {
    connectState = false;
    if (webSocket != null) {
      webSocket.close();
    }
  }
}

class DialogRouter extends PageRouteBuilder {
  final Widget page;

  DialogRouter(this.page)
      : super(
          opaque: false,
          barrierColor: Color(0x00000001),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
}

class MessageDialog extends StatefulWidget {
  final data;
  MessageDialog({Key key, this.data}) : super(key: key);

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            width: double.infinity,
            height: 80,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      IconData(0xe634, fontFamily: 'MdsIcon'),
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.data['workShopName:'] ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            widget.data['msgContent'] ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
