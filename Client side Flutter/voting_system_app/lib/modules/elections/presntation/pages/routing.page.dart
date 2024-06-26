// ignore_for_file: must_be_immutable
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voting_system_app/common/utils/dummydata/dummy.data.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/create.room.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/profile.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/home.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/rooms.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/saved.rooms.page.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({super.key});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  List<Widget> pages = [
    HomePage(),
    SavedRooms(rooms: TestData.savedRooms),
    CreateRoomPage(),
    RoomsPage(
      rooms: [],
    ),
    ProfilePage(),
  ];
  List<Icon> items = const [
    Icon(Icons.home, color: Colors.white, size: 37),
    Icon(FontAwesomeIcons.bookmark, color: Colors.white, size: 30),
    Icon(Icons.add_box_rounded, color: Colors.white, size: 37),
    Icon(Icons.list_alt_outlined, color: Colors.white, size: 37),
    Icon(Icons.person_3, color: Colors.white, size: 37),
  ];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
          items: items,
          index: index,
          animationDuration: const Duration(milliseconds: 250),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Theme.of(context).primaryColor,
          color: Theme.of(context).primaryColor,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }
}
