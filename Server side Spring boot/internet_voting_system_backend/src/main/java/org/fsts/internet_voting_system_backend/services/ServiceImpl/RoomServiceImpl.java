package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.repositories.RoomRepository;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class RoomServiceImpl implements RoomService {
    private final RoomRepository roomRepository;
    @Override
    public Room saveRoom(Room room) {
        room.setRoomId(UUID.randomUUID().toString());
        return roomRepository.save(room);
    }

    @Override
    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }

    @Override
    public Room updateRoom(Room room) {
        return roomRepository.save(room);
    }
}
