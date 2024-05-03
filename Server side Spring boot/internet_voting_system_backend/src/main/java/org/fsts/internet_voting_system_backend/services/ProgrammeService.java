package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface ProgrammeService {
    public Programme saveProgramme(Programme programme);
    public List<Programme> getAllProgrammes();
    public Programme getProgrammeById(String progId);
    public  List<Programme> findProgrammeByDateAndRoom(LocalDate date, Room room);
}
