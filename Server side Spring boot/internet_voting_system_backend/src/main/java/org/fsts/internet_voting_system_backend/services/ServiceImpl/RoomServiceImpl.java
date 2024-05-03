package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.RoomDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.repositories.RoomRepository;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@AllArgsConstructor
public class RoomServiceImpl implements RoomService {
    private final RoomRepository roomRepository;
    private final UserService userService;
    private final ProgrammeService programmeService;
    private final RoomService roomService;
    @Override
    public Room saveRoom(Room room) {
        room.setRoomId(UUID.randomUUID().toString());
        return roomRepository.save(room);
    }

    @Override
    public Room getRoomById(String roomId) {
        return roomRepository.findById(roomId).orElseThrow(()->new RuntimeException("Room with id"+roomId+" not found"));
    }

    @Override
    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }

    @Override
    public Room updateRoom(Room room) {
        return roomRepository.save(room);
    }

    @Override
    public List<Room> getUserJoiningRooms(String userId) {
        return userService.getUserById(userId).getJoiningRooms();
    }

    @Override
    public List<Room> getUserCreatedRooms(String userId) {
        return null;
    }

    @Override
    public Optional<List<Programme>> getProgrammesByRoom(String roomId) {
        return roomRepository.findProgrammeListByRoomId(roomId);
    }

    @Override
    public Optional<List<Room>> getRoomsByKeyword(String key) {
        return roomRepository.findByTitleContainingIgnoreCase(key);
    }
    @Override
    public Optional<List<Room>> getAllRoom() {
        return Optional.of(roomRepository.findAll());
    }

    @Override
    public Room addProgrammeToRoom(String roomId, String programmeId) {
        Room room=roomService.getRoomById(roomId);
        Programme programme=programmeService.getProgrammeById(programmeId);
        if (room == null || programme == null) {
            return null;
        }
        room.getProgrammeList().add(programme);
        programme.setProgrammeRoom(room);
        roomService.saveRoom(room);
        programmeService.saveProgramme(programme);
        return room;
    }


}
