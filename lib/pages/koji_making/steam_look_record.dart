import 'package:dfmdsapp/utils/index.dart';

class SteamLookRecordPage extends StatefulWidget {
  final arguments;
  SteamLookRecordPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamLookRecordPageState createState() => _SteamLookRecordPageState();
}

class _SteamLookRecordPageState extends State<SteamLookRecordPage> {
  List listData = [{}, {}];

  Widget _listWidget(index) {
    if (index == 0) {
      return Container();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
      title: widget.arguments['title'],
      headTitle: 'A-1  曲房',
      headSubTitle: '六月香生酱',
      headThreeTitle: '生产订单：83300023456',
      headFourTitle: '入曲日期：2020-07-20',
      listData: listData,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamLookRecordAdd',
            arguments: {});
      },
      submitFn: () {},
      listWidget: _listWidget,
    );
  }
}
