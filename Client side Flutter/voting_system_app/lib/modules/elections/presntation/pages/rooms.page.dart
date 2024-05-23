import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/verfication.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.aramali.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key, required this.rooms});
  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rooms.isNotEmpty ? rooms.first.category : "No rooms"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        children: List.generate(
          rooms.length,
          (index) => RoomCardBar(
            room: rooms[index],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (C) =>
                          VerificationMemeberPage(room: rooms[index])));
            },
          ),
        ),
      )),
    );
  }
}
