// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';

class ProgrammePage extends StatelessWidget {
  ProgrammePage({super.key, required this.programme});
  Programme programme;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Programme Page"),
      ),
    );
  }
}
