import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/verfication.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.aramali.dart';

class RoomsPage extends StatefulWidget {
  RoomsPage({super.key, required this.rooms});
  List<Room> rooms;

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _getStorage = GetStorage();
  late String _loggedUser;
  bool isLoading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loggedUser = _getStorage.read("loged-user");
    // _loggedUser = "moha123";
    fetchRooms();
  }

  fetchRooms() async {
    final resp = await serviceLocatorElection<RoomRepository>().getAllRooms();
    resp.fold(
      (l) {
        error = l.message;
      },
      (r) {
        widget.rooms = r;
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  bool isCreated(Room room) {
    print(room.roomId);
    print(room.creatorUserName);
    return _loggedUser == room.creatorUserName;
  }

  @override
  Widget build(BuildContext context) {
    final createdRooms = widget.rooms.where((room) => isCreated(room)).toList();
    final joinedRooms = widget.rooms.where((room) => !isCreated(room)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rooms",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          controller: _tabController,
          unselectedLabelColor: Colors.blue[100],
          tabs: [
            Tab(text: "Created"),
            Tab(text: "Joining"),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : TabBarView(
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
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
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
        ),
      ),
    );
  }
}
