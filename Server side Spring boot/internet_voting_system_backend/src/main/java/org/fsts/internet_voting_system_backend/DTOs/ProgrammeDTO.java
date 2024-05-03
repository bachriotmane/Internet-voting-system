package org.fsts.internet_voting_system_backend.DTOs;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public record ProgrammeDTO(
        String programmeId,
        String programmeTitle,
        String programmeDescription,
        String programmeRoom,
        LocalDate creationDate,
        List<String> voteIds
) {
}
