import 'package:flutter/material.dart';
import '../../../components/appBar.dart';

class AcceAddListPage extends StatefulWidget {
  AcceAddListPage({Key key}) : super(key: key);

  @override
  _AcceAddListPageState createState() => _AcceAddListPageState();
}

class _AcceAddListPageState extends State<AcceAddListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(),
    );
  }
}
