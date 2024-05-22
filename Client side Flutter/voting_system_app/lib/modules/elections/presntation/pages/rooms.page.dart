import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key, required this.rooms});
  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: List.generate(
          rooms.length,
          (index) => Container(
            child: Text(rooms[index].roomTitle),
          ),
        ),
      )),
    );
  }
}
