import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/utils/dummydata/room.categories.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/button.custom.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/textfiled.custom.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/blocs/addroom/addroom_bloc.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/routing.page.dart';

String generateUniqueCode() {
  Random random = Random();
  int code = random.nextInt(9000) + 1000;
  return code.toString();
}

class CreateRoomPage extends StatefulWidget {
  CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String? dropdownValue;
  String? code;

  DateTime startDate = DateTime.now();
  TimeOfDay startTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  DateTime endDate = DateTime.now();
  TimeOfDay endTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
  }

  final bloc = AddroomBloc();
  initStateStat() {
    bloc.add(AddroomInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    initStateStat();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new room",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AddroomBloc, AddroomState>(
        bloc: bloc,
        listenWhen: (previews, current) => current is AddroomActionState,
        buildWhen: (previews, current) => current is! AddroomActionState,
        listener: (context, state) {
          if (state is AddroomRoomAddedSuccessfullyActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Room added Successfully! code : $code"),
              backgroundColor: Colors.green,
            ));

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => RoutingPage()));
          }
        },
        builder: (context, state) {
          if (state is AddroomLoadedSuccessState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! Image Here if we still have time
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  MyTextFiled(
                      hintText: "Room title", controller: titleController),
                  MyTextFiled(
                      hintText: "Room description", controller: descController),
                  _buildTextDivider("Room will start at:"),
                  _buildDateInputs(startDate, startTime, true),
                  _buildTextDivider("Room will expire at:"),
                  _buildDateInputs(endDate, endTime, false),
                  _buildCategoriesDropDownMenu(),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: MyCustomeButton(
                      textButton: "create",
                      onTap: () {
                        code = generateUniqueCode();
                        DateTime startAt = DateTime(
                            startDate.year,
                            startDate.month,
                            startDate.day,
                            startTime.hour,
                            startTime.minute);
                        DateTime expireAt = DateTime(
                            endDate.year,
                            endDate.month,
                            endDate.day,
                            endTime.hour,
                            endTime.minute);
                        Room room = Room(
                          roomId: "",
                          roomTitle: titleController.text,
                          roomDesc: descController.text,
                          createAt: DateTime.now(),
                          startAt: startAt,
                          expireAt: expireAt,
                          code: code ?? "",
                          members: [],
                          category: dropdownValue ?? "Politics and Governance",
                          creatorUserName: GetStorage().read("loged-user"),
                          programmes: [],
                        );
                        bloc.add(AddroomCreateButtonClickedEvent(room: room));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AddroomLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddroomErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Text("oops Unknown state!");
          }
        },
      ),
    );
  }

  Widget _buildDateInputs(DateTime date, TimeOfDay time, bool isStart) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
              onTap: () async {
                _selectDate(context).then((value) {
                  setState(() {
                    setState(() {
                      if (value != null) {
                        if (isStart) {
                          startDate = value;
                        } else {
                          endDate = value;
                        }
                      }
                    });
                  });
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${date.year}/${date.month}/${date.day}",
                  style: TextStyle(fontSize: 20),
                ),
              )),
        ),
        Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                _selectTime(context).then((value) {
                  setState(() {
                    if (value != null) {
                      if (isStart) {
                        startTime = value;
                      } else {
                        endTime = value;
                      }
                    }
                  });
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${time.hour}:${time.minute}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )),
      ],
    );
  }

  _buildTextDivider(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoriesDropDownMenu() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DropdownButton<String>(
        isExpanded: true,
        alignment: Alignment.center,
        borderRadius: BorderRadius.circular(10),
        padding: const EdgeInsets.all(5),
        hint: const Text(
          "Category",
          style: TextStyle(color: Colors.black),
        ),
        value: dropdownValue,
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: categoryList.map<DropdownMenuItem<String>>((Map value) {
          return DropdownMenuItem<String>(
            value: value["categoryName"],
            child: Text(value["categoryName"]),
          );
        }).toList(),
      ),
    );
  }
}
