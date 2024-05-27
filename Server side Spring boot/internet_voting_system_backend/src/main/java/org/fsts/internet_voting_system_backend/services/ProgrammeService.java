package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface ProgrammeService {
    public Programme saveProgramme(Programme programme);
    public List<Programme> getAllProgrammes();
    public Optional<Programme> getProgrammeById(String progId);
    public  List<Programme> findProgrammeByDateAndRoom(LocalDate date, Room room);
    List<Programme> findProgrammeByKeywordAndRoom(
            String keyword, Room programmeRoom
    );

    public Programme updateProgramme(Programme programme);
}
