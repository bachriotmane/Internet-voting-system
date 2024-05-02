package org.fsts.internet_voting_system_backend.mappers;

import org.fsts.internet_voting_system_backend.DTOs.ProgrammeDTO;
import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.UserApp;

public interface ProgrammeMapper {
    public Programme fromDTO(ProgrammeDTO programmeDTO);
    public ProgrammeDTO fromEntity(Programme programme);
}
