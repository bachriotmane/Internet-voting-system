// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';

class ProgrammeCard extends StatelessWidget {
  ProgrammeCard({
    Key? key,
    required this.programme,
    this.onTap,
  }) : super(key: key);
  final Programme programme;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(2, 4),
              color: Colors.grey[300]!,
            )
          ],
        ),
        child: Column(
          children: [
            //! Created At
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    "${programme.creationDate.hour}:${programme.creationDate.minute} am")
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 22,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/homepage/profile.png"),
                    radius: 20,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Otmane Bachri",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(programme.programmeDesc)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
