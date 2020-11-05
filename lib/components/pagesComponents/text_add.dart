import 'package:dfmdsapp/utils/index.dart';

class TextAddPage extends StatefulWidget {
  final arguments;
  TextAddPage({
    Key key,
    this.arguments,
  }) : super(key: key);

  @override
  _TextAddPageState createState() => _TextAddPageState();
}

class _TextAddPageState extends State<TextAddPage> {
  bool addOrUpdate = true;
  Map<String, dynamic> formMap = {'text': ''};

  @override
  void initState() {
    if (widget.arguments['data'] != null && widget.arguments['data'] != '') {
      addOrUpdate = false;
      formMap['text'] = jsonDecode(
          jsonEncode(widget.arguments['data'][widget.arguments['textField']]));
    } else {
      addOrUpdate = true;
    }
    setState(() {});
    super.initState();
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(children: <Widget>[
        TextField(
          controller: TextEditingController.fromValue(TextEditingValue(
              text: formMap['text'],
              // 保持光标在最后
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: formMap['text'].length)))),
          maxLines: 4,
          textAlign: TextAlign.left,
          decoration: InputDecoration(border: OutlineInputBorder()),
          onChanged: (val) {
            this.setState(() {
              formMap['text'] = val;
            });
          },
        ),
      ]),
    );
  }

  _submitForm() async {
    if (formMap['text'] == null || formMap['text'] == '') {
      EasyLoading.showError('请填写备注');
      return;
    }
    if (addOrUpdate) {
      var obj = jsonDecode(jsonEncode(widget.arguments['params']));
      obj[widget.arguments['textField']] = formMap['text'];
      try {
        await widget.arguments['api'](obj);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      var obj = jsonDecode(jsonEncode(widget.arguments['data']));
      obj[widget.arguments['textField']] = formMap['text'];
      try {
        await widget.arguments['api'](obj);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: addOrUpdate ? '新增' : '修改'),
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
