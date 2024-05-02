package org.fsts.internet_voting_system_backend.DTOs;

import java.util.List;

public record ProgrammeDTO(
        String programmeId,
        String programmeTitle,
        String programmeDescription,
        String programmeRoom,
        List<String> voteIds
) {
}
