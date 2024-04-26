package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Room;

import java.util.List;

public interface RoomService {
    public Room saveRoom(Room room);
    public List<Room> getAllRooms();
    public Room updateRoom(Room room);
}
