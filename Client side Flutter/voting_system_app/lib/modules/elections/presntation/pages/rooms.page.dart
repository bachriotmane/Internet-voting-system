import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/verfication.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.aramali.dart';

class RoomsPage extends StatefulWidget {
  RoomsPage({super.key, required this.rooms});
  final List<Room> rooms;

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _getStorage = GetStorage();
  late String _loggedUser;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loggedUser = _getStorage.read("loged-user");
  }

  bool isCreated(Room room) {
    return _loggedUser == room.creatorUserName;
  }

  @override
  Widget build(BuildContext context) {
    final createdRooms = widget.rooms.where((room) => isCreated(room)).toList();
    final joinedRooms = widget.rooms.where((room) => !isCreated(room)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.rooms.isNotEmpty ? widget.rooms.first.category : "No rooms"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Created"),
            Tab(text: "Joining"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildRoomList(context, createdRooms),
          buildRoomList(context, joinedRooms),
        ],
      ),
    );
  }

  Widget buildRoomList(BuildContext context, List<Room> rooms) {
    return Center(
      child: Column(
        children: List.generate(
          rooms.length,
          (index) => RoomCardBar(
            room: rooms[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VerificationMemeberPage(room: rooms[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
