import 'package:carros/resources/prefs.dart';
import 'package:carros/services/api_carros.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      Prefs.setInt('tabIndex', _tabController.index);
    });

    _tabController.index = await Prefs.getInt('tabIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'Clássicos'),
            Tab(text: 'Esportivos'),
            Tab(text: 'Luxuosos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo),
        ],
      ),
      drawer: DrawerMenu(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
