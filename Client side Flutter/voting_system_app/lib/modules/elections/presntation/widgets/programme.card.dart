// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';

class ProgrammeCard extends StatelessWidget {
  const ProgrammeCard({
    Key? key,
    required this.programme,
  }) : super(key: key);
  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Programme Card"),
    );
  }
}
