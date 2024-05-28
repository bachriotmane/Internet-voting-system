// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/room.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.aramali.dart';

class SimpleRoomsPage extends StatelessWidget {
  SimpleRoomsPage({super.key, required this.rooms});
  List<Room> rooms;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(rooms[0] != null ? rooms[0].category : "No rooms"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: List.generate(
            rooms.length,
            (index) => RoomCardBar(
                room: rooms[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RoomPage(room: rooms[index]),
                    ),
                  );
                })),
      ),
    );
  }
}
