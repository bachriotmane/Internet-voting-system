import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';

class RoomCardBar extends StatelessWidget {
  final RoomModel room;
  RoomCardBar({Key? key, required this.room}) : super(key: key);

  final df = DateFormat('dd-MM-yyyy hh:ma');
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              room.image,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                room.roomTitle,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                room.roomDesc,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
                overflow: TextOverflow.clip,
                softWrap: true,
              ),
              Align(
                child: Row(
                  children: [
                    Text(
                      'created at : ${df.format(room.createAt)}',
                      style: const TextStyle(
                        fontSize: 7,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Expired at : ${df.format(room.expireAt)}',
                      style: const TextStyle(
                        fontSize: 7,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          )
        ],
      ),
    );
  }
}
