package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.repositories.ProgrammeRepository;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class ProgrammeServiceImpl implements ProgrammeService {
    private final ProgrammeRepository programmeRepository;
    @Override
    public Programme saveProgramme(Programme programme) {
        programme.setProgrammeId(UUID.randomUUID().toString());
        return programmeRepository.save(programme);
    }

    @Override
    public List<Programme> getAllProgrammes() {
        return programmeRepository.findAll();
    }

    @Override
    public Programme getProgrammeById(String progId) {
        return programmeRepository.findById(progId).orElseThrow(()->new RuntimeException("Programme with id "+progId+" not found"));
    }
}
