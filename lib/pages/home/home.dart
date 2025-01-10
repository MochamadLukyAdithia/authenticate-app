import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _kTabPage = <Widget>[
    Center(
      child: Icon(Icons.home, size: 64, color: Colors.redAccent),
    ),
    Center(
      child: Icon(Icons.camera, size: 64, color: Colors.redAccent),
    ),
    Center(
      child: Icon(Icons.settings, size: 64, color: Colors.redAccent),
    ),
  ];

  static const _kTabs = <Widget>[
    Tab(
      icon: Icon(
        Icons.home,
        color: Colors.redAccent,
      ),
      text: 'Home',
    ),
    Tab(
      icon: Icon(
        Icons.camera,
        color: Colors.redAccent,
      ),
      text: 'Camera',
    ),
    Tab(
      icon: Icon(
        Icons.settings,
        color: Colors.redAccent,
      ),
      text: 'Settings',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPage.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.amberAccent.shade400,
      body: TabBarView(
        controller: _tabController,
        children: _kTabPage,
      ),
      bottomNavigationBar: Material(
        color: Colors.amberAccent.shade700,
        child: TabBar(
          tabs: _kTabs,
          controller: _tabController,
        ),
      ),
    );
  }
}
