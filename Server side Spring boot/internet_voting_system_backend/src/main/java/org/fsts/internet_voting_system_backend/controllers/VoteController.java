package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/votes")
@AllArgsConstructor
public class VoteController {
    private final VoteService voteService;
    private final VoteMapper voteMapper;
    private final ProgrammeService programmeService;

    @PostMapping("/")
    public ResponseEntity<?> voterProgramme(@RequestBody VoteDTO voteDTO){
        Optional<Programme> programme = programmeService.getProgrammeById(voteDTO.programmeId());
        if(programme.isPresent()){
            Vote vote = voteService.saveVote(voteMapper.fomDTO(voteDTO));
            programme.get().getVoteList().add(vote);
            Programme programme1 =  programmeService.saveProgramme(programme.get());
            vote.setProgramme(programme1);
            voteService.saveVote(vote);
            return ResponseEntity.ok(voteMapper.fromEntity(vote));
        }
        return new ResponseEntity<>("Programme not found with id " + voteDTO.programmeId(), HttpStatus.NOT_FOUND);

    }
}
