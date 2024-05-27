package org.fsts.internet_voting_system_backend;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.*;
import org.fsts.internet_voting_system_backend.repositories.RoomCategoryRepository;
import org.fsts.internet_voting_system_backend.security.RsaKeyConfig;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


@SpringBootApplication
@AllArgsConstructor
@EnableConfigurationProperties(RsaKeyConfig.class)
public class InternetVotingSystemBackendApplication {

	private final UserService userService;
	private final ProgrammeService programmeService;
	private final VoteService voteService;
	private final RoomService roomService;
	private final RoomCategoryRepository roomCategoryRepository;

	public static void main(String[] args) {
		SpringApplication.run(InternetVotingSystemBackendApplication.class, args);
	}
	@Bean
	CommandLineRunner commandLineRunner(){
		return (args)->{
			RoomCategory roomCategory1 = RoomCategory.builder().id("1").label("Politics and Governance").build();
			RoomCategory roomCategory2 = RoomCategory.builder().id("2").label("Social Issues and Advocacy").build();
			RoomCategory roomCategory3 = RoomCategory.builder().id("3").label("Health and Wellness").build();

			RoomCategory roomCategory4 = RoomCategory.builder().id(UUID.randomUUID().toString()).label("Technology and Innovation").build();
			RoomCategory roomCategory5 = RoomCategory.builder().id(UUID.randomUUID().toString()).label("Arts and Culture").build();
			RoomCategory roomCategory6 = RoomCategory.builder().id(UUID.randomUUID().toString()).label("Education and Learning").build();
			RoomCategory roomCategory7 = RoomCategory.builder().id(UUID.randomUUID().toString()).label("Environmental Conservation").build();
			RoomCategory roomCategory8 = RoomCategory.builder().id(UUID.randomUUID().toString()).label("Public Safety and Security").build();

			roomCategory1 = roomCategoryRepository.save(roomCategory1);
			roomCategory2 = roomCategoryRepository.save(roomCategory2);
			roomCategory3 = roomCategoryRepository.save(roomCategory3);

			roomCategoryRepository.save(roomCategory4);
			roomCategoryRepository.save(roomCategory5);
			roomCategoryRepository.save(roomCategory6);
			roomCategoryRepository.save(roomCategory7);
			roomCategoryRepository.save(roomCategory8);



			UserApp user1 = UserApp.builder().nom("BACHRI").age(22).CIN("AM67679").email("bachriotmane@gmail.com").phoneNumber("0615314354").password("123456").prenom("Otmane").username("otmane12").build();
			UserApp user2 = UserApp.builder().nom("ARAMALI").age(32).CIN("V78890").email("aramali@gmail.com").phoneNumber("06778621").password("aramali").prenom("Mohamed").username("moha123").build();
			UserApp user3 = UserApp.builder().nom("IDRISSI").age(27).CIN("HN12321").email("idrissi@gmail.com").phoneNumber("068921123").password("id898").prenom("AbdLakrim").username("idr789").build();
			userService.saveUser(user1);
			userService.saveUser(user2);
			userService.saveUser(user3);
			List<UserApp> members = new ArrayList<>();
			members.add(user1);
			members.add(user2);



			LocalDateTime localDateTime = LocalDateTime.of(2024,06,26,17,22);
			Instant instant = localDateTime.atZone(ZoneId.systemDefault()).toInstant();
			Room room1 = Room.builder().code("4565").roomDescription("room1 desc").createAt(new Date()).title("room1").expireAt(Date.from(instant)).startAt(new Date()).build();
			Room room2 = Room.builder().code("9802").roomDescription("room2 desc").createAt(new Date()).title("room2").expireAt(Date.from(instant)).startAt(new Date()).build();
			Room room3 = Room.builder().code("1235").roomDescription("room2 desc").createAt(new Date()).title("room3").expireAt(Date.from(instant)).startAt(new Date()).build();

			room1.setRoomCreator(user1);
			room2.setRoomCreator(user2);
			room3.setRoomCreator(user3);

			room1.setRoomCategory(roomCategory1);
			room2.setRoomCategory(roomCategory2);
			room3.setRoomCategory(roomCategory3);

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

			Programme programme1 = Programme.builder().creator(user1).programmeDescription("Prog1 Desc").programmeTitle("Prog1").programmeRoom(room1).creationDate(new Date()).build();
			Programme programme2 = Programme.builder().creator(user2).programmeDescription("Prog2 Desc").programmeTitle("Prog2").programmeRoom(room2).creationDate(new Date()).build();
			Programme programme3 = Programme.builder().creator(user3).programmeDescription("Prog3 Desc").programmeTitle("Ping").programmeRoom(room2).creationDate(new Date()).build();

			programmeService.saveProgramme(programme1);
			programmeService.saveProgramme(programme2);
			programmeService.saveProgramme(programme3);

			//add programmes to room1
			List<Programme> programmes = new ArrayList<>();
			programmes.add(programme1);
			programmes.add(programme2);
			programmes.add(programme3);
			room1.setProgrammeList(programmes);
			roomService.updateRoom(room1);
//			List<Vote> votes = new ArrayList<>();

//			Vote vote1 =  Vote.builder().dateVote(new Date()).programme(programme1).voter(user1).build();
//			Vote vote2 =  Vote.builder().dateVote(new Date()).programme(programme1).voter(user2).build();
//			Vote vote3 =  Vote.builder().dateVote(new Date()).programme(programme2).voter(user3).build();

//			vote1 = voteService.saveVote(vote1);
//			vote2 = voteService.saveVote(vote2);
//			voteService.saveVote(vote3);
//			votes.add(vote1);
//			votes.add(vote2);
//
//			programme1.setVoteList(votes);
//			programmes.add(programme1);
//			vote1.setProgramme(programme1);
//			programmeService.saveProgramme(programme1);
		};
	}
}
