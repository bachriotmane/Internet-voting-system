import 'package:flutter/material.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/user.datasource.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          serviceLocator<UserDataSource>();
          final voteDataSource = serviceLocatorElection<VoteDataSource>();
          await voteDataSource.getAllVotes();
        },
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
