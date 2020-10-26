import 'package:dfmdsapp/utils/index.dart';
import 'package:dfmdsapp/components/pagesComponents/list.dart';

class ExeptionListPage extends StatefulWidget {
  final arguments;
  ExeptionListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ExeptionListPageState createState() => _ExeptionListPageState();
}

class _ExeptionListPageState extends State<ExeptionListPage> {
  @override
  Widget build(BuildContext context) {
    return ListPageWidget(
      title: widget.arguments['title'],
      api: Sterilize.sterilizeListApi,
      tabs: [
        {'label': '未录入', 'type': 'not'},
        {'label': '已录入', 'type': 'not'},
      ],
      params: {
        'workShop': '85002011',
        'workingType': widget.arguments['workingType'],
        'potNo': '1',
      },
      itemBuilder: (context, index, listviewList) {
        return Container();
      },
    );
  }
}
