package org.fsts.internet_voting_system_backend;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@SpringBootApplication
@AllArgsConstructor
public class InternetVotingSystemBackendApplication {

	private final UserService userService;
	private final ProgrammeService programmeService;
	private final VoteService voteService;
	private final RoomService roomService;

	public static void main(String[] args) {
		SpringApplication.run(InternetVotingSystemBackendApplication.class, args);
	}
	@Bean
	CommandLineRunner commandLineRunner(){
		return (args)->{
			UserApp user1 = UserApp.builder().nom("BACHRI").age(22).CIN("AM67679").email("bachriotmane@gmail.com").phoneNumber("0615314354").password("123456").prenom("Otmane").userName("otmane12").build();
			UserApp user2 = UserApp.builder().nom("ARAMALI").age(32).CIN("V78890").email("aramali@gmail.com").phoneNumber("06778621").password("ar189").prenom("Mohamed").userName("moha123").build();
			UserApp user3 = UserApp.builder().nom("IDRISSI").age(27).CIN("HN12321").email("idrissi@gmail.com").phoneNumber("068921123").password("id898").prenom("AbdLakrim").userName("idr789").build();
			userService.saveUser(user1);
			userService.saveUser(user2);
			userService.saveUser(user3);
			List<UserApp> members = new ArrayList<>();
			members.add(user1);
			members.add(user2);



			LocalDateTime localDateTime = LocalDateTime.of(2024,04,26,17,22);
			Instant instant = localDateTime.atZone(ZoneId.systemDefault()).toInstant();

			Room room1 = Room.builder().code("4565").roomDescription("room1 desc").createAt(new Date()).title("room2").expireAt(Date.from(instant)).startAt(new Date()).build();
			Room room2 = Room.builder().code("9802").roomDescription("room2 desc").createAt(new Date()).title("room2").expireAt(Date.from(instant)).startAt(new Date()).build();
			Room room3 = Room.builder().code("1235").roomDescription("room2 desc").createAt(new Date()).title("room2").expireAt(Date.from(instant)).startAt(new Date()).build();
			room1.setRoomCreator(user1);
			room2.setRoomCreator(user2);
			room3.setRoomCreator(user3);
			roomService.saveRoom(room1);
			roomService.saveRoom(room2);
			roomService.saveRoom(room3);

			List<Room> rooms = new ArrayList<>();
			rooms.add(room1);
			rooms.add(room2);
			rooms.add(room3);

			user1.setCreatedRooms(rooms);
			user2.setCreatedRooms(rooms);

			user1.setJoiningRooms(rooms);
			user2.setJoiningRooms(rooms);

			userService.updateUser(user1);
			userService.updateUser(user2);



			Programme programme1 = Programme.builder().programmeDescription("Prog1 Desc").programmeTitle("Prog1").build();
			Programme programme2 = Programme.builder().programmeDescription("Prog2 Desc").programmeTitle("Prog2").build();
			Programme programme3 = Programme.builder().programmeDescription("Prog3 Desc").programmeTitle("Prog3").build();

			programmeService.saveProgramme(programme1);
			programmeService.saveProgramme(programme2);
			programmeService.saveProgramme(programme3);

			Vote vote1 =  Vote.builder().dateVote(new Date()).programme(programme1).voter(user1).build();
			Vote vote2 =  Vote.builder().dateVote(new Date()).programme(programme1).voter(user2).build();
			Vote vote3 =  Vote.builder().dateVote(new Date()).programme(programme2).voter(user3).build();

			voteService.saveVote(vote1);
			voteService.saveVote(vote2);
			voteService.saveVote(vote3);

		};
	}
}
