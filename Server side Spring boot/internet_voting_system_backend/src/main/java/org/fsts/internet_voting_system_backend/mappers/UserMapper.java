package org.fsts.internet_voting_system_backend.mappers;

import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.UserApp;

public interface UserMapper {
    public UserApp fromDTO(UserDTO userDTO);
    public UserDTO fromEntity( UserApp userApp);
}
