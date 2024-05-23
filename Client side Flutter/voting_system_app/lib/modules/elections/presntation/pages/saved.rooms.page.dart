import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
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
            rooms.length,
            (index) => RoomCardBar(
              room: rooms[index],
              onTap: () {},
            ),
          ),
        ));
  }
}
