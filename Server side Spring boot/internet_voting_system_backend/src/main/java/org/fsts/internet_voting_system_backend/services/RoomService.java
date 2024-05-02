package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;

import java.util.List;
import java.util.Optional;

public interface RoomService {
    public Room saveRoom(Room room);
    public Room getRoomById(String roomId);
    public List<Room> getAllRooms();
    public Room updateRoom(Room room);

    public List<Room> getUserJoiningRooms(String userId);
    public List<Room> getUserCreatedRooms(String userId);

    public Optional<List<Programme>> getProgrammesByRoom(String roomId);

    public Optional<List<Room>> getRoomsByKeyword(String key);
    public Optional<List<Room>> getAllRoom();
}
