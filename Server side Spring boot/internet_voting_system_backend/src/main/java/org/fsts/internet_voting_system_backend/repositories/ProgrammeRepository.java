package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface ProgrammeRepository extends JpaRepository<Programme, String> {
    public List<Programme> findProgrammeByProgrammeRoomAndCreationDateOrderByCreationDateAsc(
            LocalDate creationDate, Room programmeRoom
    );

}
