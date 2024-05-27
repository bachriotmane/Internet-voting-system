import 'package:flutter/material.dart';
import 'package:voting_system_app/common/utils/dummydata/dummy.data.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/room.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.aramali.dart';

class SavedRooms extends StatelessWidget {
  const SavedRooms({super.key, required this.rooms});
  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Saved rooms",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: List.generate(
            TestData.savedRooms.length,
            (index) => RoomCardBar(
              room: TestData.savedRooms[index],
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) =>
                            RoomPage(room: TestData.savedRooms[index])));
              },
            ),
          ),
        ));
  }
}
