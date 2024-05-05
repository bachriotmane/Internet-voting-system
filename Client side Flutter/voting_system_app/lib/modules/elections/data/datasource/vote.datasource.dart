import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';

abstract class VoteDataSource {
  Future<List<VoteModel>> getAllVotes();
}
