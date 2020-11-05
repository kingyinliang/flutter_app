import 'package:dfmdsapp/utils/index.dart';

class ExeptionPage extends StatefulWidget {
  final arguments;
  ExeptionPage({Key key, this.arguments}) : super(key: key);

  @override
  _ExeptionPageState createState() => _ExeptionPageState();
}

class _ExeptionPageState extends State<ExeptionPage> {
  String tag = '';
  List exceptionList = []; // 异常列表
  List textList = []; // 文本列表

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  _initState() async {
    try {
      if (widget.arguments['workingType'] == 'STEAM_BEAN_EXCEPTION') {
        tag = 'YP';
      } else if (widget.arguments['workingType'] == 'DISC_EXCEPTION') {
        tag = 'ZD';
      } else if (widget.arguments['workingType'] == 'STEAM_FLOUR_EXCEPTION') {
        tag = 'ZM';
      }
      // 异常列表
      var res = await KojiMaking.steamExeptionQuery({
        "orderNo": widget.arguments['data']['orderNo'],
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
        "exceptionStage": tag,
      });
      this.exceptionList = res['data'];
      // 文本列表
      var testRes = await KojiMaking.steamTextQuery({
        "orderNo": widget.arguments['data']['orderNo'],
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
        "textStage": tag,
      });
      if (testRes['data'] != null) {
        this.textList = [testRes['data']];
      }
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return ExeptionWidget(
      title: widget.arguments['title'],
      status: exceptionList.length > 0 ? '' : '',
      statusName: exceptionList.length > 0 ? '已录入' : '未录入',
      headTitle: '${widget.arguments['data']['kojiHouseName']}',
      headSubTitle: '${widget.arguments['data']['materialName']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '生产日期：${widget.arguments['data']['productDate']}',
      exceptionList: exceptionList,
      textList: textList,
      textField: 'kojiText',
      addOnFn: (index) {
        if (index == 0) {
        } else {
          Navigator.pushNamed(
            context,
            '/textAdd',
            arguments: {
              'params': {
                "orderNo": widget.arguments['data']['orderNo'],
                "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
                'textStage': tag,
              },
              'api': KojiMaking.steamTextSave,
              'textField': 'kojiText',
            },
          ).then((value) => value != null ? _initState() : null);
        }
      },
      textOnFn: (index) {
        Navigator.pushNamed(
          context,
          '/textAdd',
          arguments: {
            'data': textList[0],
            'api': KojiMaking.steamTextSave,
            'textField': 'kojiText',
          },
        ).then((value) => value != null ? _initState() : null);
      },
      exeOnFn: (index) {},
      delFn: (index) {},
    );
  }
}
