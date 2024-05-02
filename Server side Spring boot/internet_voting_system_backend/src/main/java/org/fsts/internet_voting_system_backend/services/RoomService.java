package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Room;

import java.util.List;

public interface RoomService {
    public Room saveRoom(Room room);
    public Room getRoomById(String roomId);
    public List<Room> getAllRooms();
    public Room updateRoom(Room room);

    public List<Room> getUserJoiningRooms(String userId);
    public List<Room> getUserCreatedRooms(String userId);

}
