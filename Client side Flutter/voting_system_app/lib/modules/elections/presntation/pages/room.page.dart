// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voting_system_app/common/utils/dummydata/dummy.data.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/home.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/programme.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/programme.card.dart';

class RoomPage extends StatelessWidget {
  RoomPage({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAlertDialog(context);
          },
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
          child: const Icon(
            size: 32,
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            //! Image with top = 0
            Positioned(
              top: 0,
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      "assets/homepage/vv.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    width: MediaQuery.of(context).size.width * .95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    color: Colors.grey[500]!)
                              ]),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => HomePage()));
                            },
                            icon: const Icon(FontAwesomeIcons.arrowLeft),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    color: Colors.grey[500]!)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.bookmark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //! ListView
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(8),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500]!,
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: _buildCard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Title
          Text(room.roomTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          //! Description
          const SizedBox(height: 10),
          //!Image + name : Creator
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/homepage/profile.png"),
              ),
              const SizedBox(width: 10),
              Text(
                room.creatorUserName,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]!),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(room.roomDesc, style: TextStyle(fontSize: 17)),
          const SizedBox(height: 20),

          const SizedBox(height: 4),
          //! 24 people are here images ... seeAll
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    room.members.length.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Text("people are here",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]!)),
                ],
              ),
              _buildImagesCircles(context),
              const Text(
                "view all",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //! Row = Start at - end Time
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor.withOpacity(0.17)),
                child: Icon(
                  FontAwesomeIcons.hourglassStart,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                  "${room.startAt.day}/${room.startAt.month}/${room.startAt.year}, ${room.startAt.hour}:${room.startAt.minute}",
                  style: TextStyle(fontSize: 22)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor.withOpacity(0.17)),
                child: Icon(
                  FontAwesomeIcons.hourglassEnd,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                  "${room.expireAt.day}/${room.expireAt.month}/${room.expireAt.year}, ${room.expireAt.hour}:${room.expireAt.minute}",
                  style: TextStyle(fontSize: 22)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: const Text(
              "Programmes ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          //! Programmes:
          _buildProgrammesList(context),
        ],
      ),
    );
  }

  List images = [
    "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
    "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg",
    "https://t3.ftcdn.net/jpg/05/52/15/68/360_F_552156839_hQTIBjd35zljkgSz65pDaUUSyKK53DtZ.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQplobh5PxL-7cf5jKxvHVxQZ2Na5SnfI9IxxFu0zA7-ZvAncIfsKb52cnV08A76cX17K4&usqp=CAU",
  ];
  Widget _buildImagesCircles(context) {
    return Row(
      children: List.generate(
        images.length,
        (index) => const Align(
          widthFactor: 0.6,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage("assets/homepage/profile.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgrammesList(context) {
    return Column(
      children: List.generate(
        TestData.getSampleProgrammes().length,
        (index) => ProgrammeCard(
          programme: TestData.getSampleProgrammes()[index],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => ProgrammePage(
                        programme: TestData.getSampleProgrammes()[index])));
          },
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create programme'),
          content: const SizedBox(
            height: 100,
            child: Column(
              children: [
                Text("Add new Programme"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
