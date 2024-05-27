package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.repositories.ProgrammeRepository;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.repositories.VoteRepository;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/votes")
@AllArgsConstructor
public class VoteController {
    private final VoteService voteService;
    private final VoteMapper voteMapper;
    private final ProgrammeService programmeService;
    private final VoteRepository voteRepository;
    private final UserAppRepository userAppRepository;
    private final ProgrammeRepository programmeRepository;

    @GetMapping("/")
    public List<VoteDTO> getAllVotes(){
        List<Vote> votes = voteService.getAllVotes();
        List<VoteDTO> voteDTOS = new ArrayList<>();
        for(Vote vote : votes){
            voteDTOS.add(voteMapper.fromEntity(vote));
        }
        return voteDTOS;
    }

    @PostMapping("/")
    public ResponseEntity<?> voterProgramme(@RequestBody VoteDTO voteDTO){
        Optional<Programme> programme = programmeService.getProgrammeById(voteDTO.programmeId());
        if(programme.isPresent()){
            Vote vote = voteService.saveVote(voteMapper.fomDTO(voteDTO));
            programme.get().getVoteList().add(vote);
            Programme programme1 =  programmeService.updateProgramme(programme.get());
            vote.setProgramme(programme1);
            Vote vote1 = voteService.updateVote(vote);
            programmeService.updateProgramme(programme.get());
            return ResponseEntity.ok(voteMapper.fromEntity(vote1));
        }
        return new ResponseEntity<>("Programme not found with id " + voteDTO.programmeId(), HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/{id}")
    public void deleteVote(@PathVariable String id){
        voteService.deleteVoteById(id);
    }

    @GetMapping("/programme/{programmeId}")
    public List<VoteDTO> getVoteParProgramme (@PathVariable String programmeId){
        List<Vote> votes =voteService.getVoteParProgramme(programmeId);
        List<VoteDTO> voteDTOS = new ArrayList<>();
        for(Vote vote : votes){
            System.out.println(vote.getVoter().getUsername());
            voteDTOS.add(voteMapper.fromEntity(vote));
        }
        return voteDTOS;
    }
    @PutMapping
    public VoteDTO updateVote(@RequestBody VoteDTO voteDTO){
        System.out.println(voteDTO.voteId());
        Vote v = voteService.updateVote(voteMapper.fomDTO(voteDTO));

        return voteMapper.fromEntity(v);
    }
}
