package org.fsts.internet_voting_system_backend.mappers;

import org.fsts.internet_voting_system_backend.DTOs.RoomDTO;
import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;

public interface RoomMapper {
    public Room fromDTO(RoomDTO roomDto);
    public RoomDTO fromEntity( Room room);
}
