import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';

class TestData {
  static List<Room> getSampleRooms() {
    return [
      Room(
        roomId: "room1",
        roomTitle: "Study Group",
        roomDesc: "Physics Chapter 5 Discussion",
        createAt: DateTime.now(),
        startAt: DateTime.now().add(Duration(hours: 1)),
        expireAt: DateTime.now().add(Duration(days: 1)),
        code: "XYZ123",
        members: ["member1", "member2", "member3"],
        creatorId: "creator1",
        programmes: ["prog1", "prog2"],
      ),
      Room(
        roomId: "room2",
        roomTitle: "Book Club",
        roomDesc: "Discussing '1984' by Orwell",
        createAt: DateTime.now(),
        startAt: DateTime.now().add(Duration(days: 1)),
        expireAt: DateTime.now().add(Duration(days: 2)),
        code: "ABC456",
        members: ["member4", "member5"],
        creatorId: "creator2",
        programmes: ["prog3"],
      ),
    ];
  }

  static List<Programme> getSampleProgrammes() {
    return [
      Programme(
        programmeId: "prog1",
        programmeTitle: "Quantum Mechanics",
        programmeDesc: "Deep dive into quantum theory",
        creationDate: DateTime.now(),
        roomId: "room1",
        creatorId: "user1",
        votes: [
          Vote(
              id: "vote1",
              date: DateTime.now(),
              voterId: "member1",
              votedProgramme: "prog1")
        ],
      ),
      Programme(
        programmeId: "prog2",
        programmeTitle: "Relativity",
        programmeDesc: "Understanding Einstein's theory",
        creationDate: DateTime.now(),
        roomId: "room1",
        creatorId: "user2",
        votes: [],
      ),
      Programme(
        programmeId: "prog3",
        programmeTitle: "Literary Analysis",
        programmeDesc: "Analyzing themes and symbols in '1984'",
        creationDate: DateTime.now(),
        roomId: "room2",
        creatorId: "user3",
        votes: [
          Vote(
              id: "vote2",
              date: DateTime.now(),
              voterId: "member5",
              votedProgramme: "prog3")
        ],
      ),
    ];
  }

  static List<Vote> getSampleVotes() {
    return [
      Vote(
        id: "vote1",
        date: DateTime.now(),
        voterId: "member1",
        votedProgramme: "prog1",
      ),
      Vote(
        id: "vote2",
        date: DateTime.now(),
        voterId: "member5",
        votedProgramme: "prog3",
      ),
    ];
  }
}
