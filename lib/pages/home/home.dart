// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   static const _kTabPage = <Widget>[
//     Center(
//       child: Icon(Icons.home, size: 64, color: Colors.redAccent),
//     ),
//     Center(
//       child: Icon(Icons.camera, size: 64, color: Colors.redAccent),
//     ),
//     Center(
//       child: Icon(Icons.settings, size: 64, color: Colors.redAccent),
//     ),
//   ];

//   static const _kTabs = <Widget>[
//     Tab(
//       icon: Icon(
//         Icons.home,
//         color: Colors.redAccent,
//       ),
//       text: 'Home',
//     ),
//     Tab(
//       icon: Icon(
//         Icons.camera,
//         color: Colors.redAccent,
//       ),
//       text: 'Camera',
//     ),
//     Tab(
//       icon: Icon(
//         Icons.settings,
//         color: Colors.redAccent,
//       ),
//       text: 'Settings',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: _kTabPage.length,
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       backgroundColor: Colors.amberAccent.shade400,
//       body: TabBarView(
//         controller: _tabController,
//         children: _kTabPage,
//       ),
//       bottomNavigationBar: Material(
//         color: Colors.amberAccent.shade700,
//         child: TabBar(
//           tabs: _kTabs,
//           controller: _tabController,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/belajar/belajar_screen.dart';
import 'package:tuna_asis/pages/home/layouts/home_screen.dart';
import 'package:tuna_asis/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final List<Widget> page;

  int selectedindex = 0;

  @override
  void initState() {
    page = [
      HomeScreen(),
      BelajarScreen(),
      navBarPage(Iconsax.camera5),
      navBarPage(Iconsax.profile_2user5),
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: page[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        onTap: (value) => {
          setState(() {
            selectedindex = value;
          })
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedindex == 0 ? Iconsax.home5 : Iconsax.home_1,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedindex == 1 ? Iconsax.star5 : Iconsax.star1,
            ),
            label: "Belajar",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedindex == 1 ? Iconsax.camera5 : Iconsax.camera,
            ),
            label: "camera",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedindex == 2
                  ? Iconsax.profile_2user5
                  : Iconsax.profile_2user,
            ),
            label: "profile",
          ),
        ],
      ),
    );
  }

  navBarPage(iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: Colors.teal,
      ),
    );
  }
}
