// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';

class ProgrammeCard extends StatefulWidget {
  ProgrammeCard({
    Key? key,
    required this.programme,
    this.onTap,
    required this.isVoted,
    required this.voter,
  }) : super(key: key);
  final Programme programme;
  void Function()? onTap;
  void Function()? voter;

  bool isVoted;

  @override
  State<ProgrammeCard> createState() => _ProgrammeCardState();
}

class _ProgrammeCardState extends State<ProgrammeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //! Created At
            Column(
              children: [
                Text(
                    "${widget.programme.creationDate.hour}:${widget.programme.creationDate.minute} am"),
                IconButton(
                  icon: Icon(
                    !widget.isVoted ? Icons.how_to_vote_outlined : Icons.check,
                    size: 40,
                  ),
                  onPressed: widget.voter,
                )
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
                    Text(
                      widget.programme.creatorId,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(widget.programme.programmeDesc)
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
