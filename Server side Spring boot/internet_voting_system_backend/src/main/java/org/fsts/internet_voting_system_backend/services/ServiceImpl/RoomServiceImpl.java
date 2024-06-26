package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.repositories.ProgrammeRepository;
import org.fsts.internet_voting_system_backend.repositories.RoomRepository;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.stereotype.Service;

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
    private final ProgrammeRepository programmeRepository;
    @Override
    public Room saveRoom(Room room) {
        room.setRoomId(UUID.randomUUID().toString());
        return roomRepository.save(room);
    }

    @Override
    public Optional<Room> getRoomById(String roomId) {
        return roomRepository.findById(roomId);
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
        return userService.getUserById(userId).get().getJoiningRooms();
    }

    @Override
    public List<Room> getUserCreatedRooms(String userId) {
        return null;
    }

    @Override
    public Optional<List<Programme>> getProgrammesByRoom(String roomId) {
        return programmeRepository.findByProgrammeRoomRoomId(roomId);
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
    public Optional<Room> addProgrammeToRoom(String roomId, String programmeId) {
        Optional<Room> room = this.getRoomById(roomId);
        Optional<Programme> programme = programmeService.getProgrammeById(programmeId);
        if (programme.isEmpty() || room.isEmpty()) {
            return Optional.empty();
        }
        Room updatedRoom = room.get();
        Programme updatedProgramme = programme.get();

        updatedRoom.getProgrammeList().add(updatedProgramme);
        updatedProgramme.setProgrammeRoom(updatedRoom);

        this.saveRoom(updatedRoom);
        programmeService.saveProgramme(updatedProgramme);

        return Optional.of(updatedRoom);
    }

    @Override
    public List<Room> getRoomsByCategory(String category) {
        List<Room>  rooms = getAllRooms();
        List<Room> wantedRooms = new ArrayList<>();

            for(Room r : rooms){
                if(r.getRoomCategory()!=null && r.getRoomCategory().getLabel().equals(category)){
                    wantedRooms.add(r);
                }
            }


        return wantedRooms;
    }


}
