package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Programme;

import java.util.List;

public interface ProgrammeService {
    public Programme saveProgramme(Programme programme);
    public List<Programme> getAllProgrammes();
    public Programme getProgrammeById(String progId);
}
