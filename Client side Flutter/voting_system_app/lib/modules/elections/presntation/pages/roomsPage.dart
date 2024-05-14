import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/presntation/blocs/bloc_rooms/city_blok_bloc.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/roomCardBar.dart';

BlocBuilder<RoomBloc, RoomBlocStat> citiesPage() {
  return BlocBuilder<RoomBloc, RoomBlocStat>(
    builder: (context, state) {
      if (state is RoomsLoading) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "List of Cities",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ));
      } else if (state is RoomsLoaded) {
        List<RoomModel> rooms = state.rooms;
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "List of cities",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
            ),
            body: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  return RoomCardBar(room: rooms[index]);
                }));
      } else {
        return const Center(
          child: Text("Something went wrong"),
        );
      }
    },
  );
}
