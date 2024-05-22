// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

class RoomCard extends StatelessWidget {
  RoomCard(
      {super.key,
      required this.saveRoom,
      required this.onClick,
      required this.room});
  void Function()? saveRoom;
  void Function()? onClick;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3))
        ]),
        width: MediaQuery.of(context).size.width * .8,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // color: Colors.red,
        child: Column(
          children: [
            //! Image
            Expanded(
                child: Stack(
              children: [
                Image.asset(
                  "assets/homepage/vv.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  right: 7,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                      onPressed: saveRoom,
                      icon: const Icon(FontAwesomeIcons.bookmark),
                    ),
                  ),
                )
              ],
            )),
            //!Other Info
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          room.roomTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //! image + Creator name
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundImage:
                                      AssetImage("assets/homepage/profile.png"),
                                ),
                                SizedBox(width: 5),
                                Text(room.creatorUserName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                            //! icon_users + number
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(
                                    Icons.people_alt_sharp,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  room.members.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
