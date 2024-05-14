import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/presntation/blocs/bloc_rooms/city_blok_bloc.dart';

class AjouterCity extends StatefulWidget {
  AjouterCity({super.key});

  @override
  State<AjouterCity> createState() => _AjouterCityState();
}

class _AjouterCityState extends State<AjouterCity> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _describtionController = new TextEditingController();
  TextEditingController _startedAtController = new TextEditingController();
  TextEditingController _expiredAtController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "City Map ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: BlocListener<RoomBloc, RoomBlocStat>(
          listener: (context, state) {
            if (state is RoomsLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Room added successfully")));
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
                child: Column(
                  children: [
                    TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                            label: Text("Title"),
                            filled: true,
                            prefixIcon: Icon(Icons.title),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _describtionController,
                      decoration: const InputDecoration(
                        label: Text("Describtion"),
                        filled: true,
                        prefixIcon: Icon(Icons.description),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _startedAtController,
                      decoration: const InputDecoration(
                        label: Text("Start at"),
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(_startedAtController);
                      },
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _expiredAtController,
                      decoration: const InputDecoration(
                        label: Text("Expired at"),
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(_expiredAtController);
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        RoomModel room = RoomModel(
                            createAt: DateTime.now(),
                            expireAt: DateTime.parse(_expiredAtController.text),
                            roomDesc: _describtionController.text,
                            roomTitle: _titleController.text,
                            startAt: DateTime.parse(_startedAtController.text),
                            code: AppConstants.generateRandomCode(6));

                        context.read<RoomBloc>().add(AddRoomEvent(room: room));
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: const Text(
                        "Enter",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(TextEditingController _date) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _date.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
