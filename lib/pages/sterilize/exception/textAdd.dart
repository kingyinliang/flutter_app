import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/api/api/index.dart';

class ExceptionTextAdd extends StatefulWidget {
  final arguments;
  ExceptionTextAdd({Key key, this.arguments}) : super(key: key);

  @override
  _ExceptionTextAddState createState() => _ExceptionTextAddState();
}

class _ExceptionTextAddState extends State<ExceptionTextAdd> {
  Map<String, dynamic> formMap = {
    'orderId': '',
    'orderNo': '',
    'potOrderId': '',
    'potOrderNo': '',
    'text': '',
    'textStage': '',
  };

  @override
  void initState() {
    print(widget.arguments);
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    Future.delayed(
      Duration.zero,
          () => setState(() {
      }),
    );
    super.initState();
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text('情况记录',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                  textAlign: TextAlign.left
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 5),
          TextField(
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: formMap['text'],
                // 保持光标在最后
                selection: TextSelection.fromPosition(
                    TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: formMap['text'].length
                    )
                )
              )
            ),
            maxLines: 4,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
            onChanged: (val) {
              this.setState(() {
                formMap['text'] = val;
              });
            },
           ),
        ]
      ),
    );
  }

  _submitForm() async {
    if (formMap['text'] == null || formMap['text'] == '') {
      EasyLoading.showError('请填写备注');
      return;
    }
    if (formMap['id'] != null) {
      try {
        await Sterilize.sterilizeExceptionDetailTextUpdateApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        formMap['textStage'] = widget.arguments['typeCode'];
        formMap['orderId'] = widget.arguments['potDetail']['orderId'];
        formMap['orderNo'] = widget.arguments['potDetail']['orderNo'];
        formMap['potOrderNo'] = widget.arguments['potDetail']['potNo'];
        formMap['potOrderId'] = widget.arguments['potDetail']['potOrderId'];
        await Sterilize.sterilizeExceptionDetailTextInsertApi(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: formMap['id'] == null ? '异常记录新增' : '异常记录修改'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          formWidget(),
          SizedBox(height: 34),
          MdsWidthButton(
            text: '确定',
            onPressed: _submitForm,
          ),
          SizedBox(height: 34),
        ],
      ),
    );
  }
}