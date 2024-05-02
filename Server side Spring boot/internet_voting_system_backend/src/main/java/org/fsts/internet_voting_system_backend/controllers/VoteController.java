package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController("/votes")
@AllArgsConstructor
public class VoteController {
    private final VoteService voteService;
    private final VoteMapper voteMapper;
    private final ProgrammeService programmeService;

    @PostMapping("/")
    public VoteDTO voterProgramme(@RequestBody VoteDTO voteDTO){
        Programme programme = programmeService.getProgrammeById(voteDTO.programmeId());
        Vote vote = voteService.saveVote(voteMapper.fomDTO(voteDTO));
        programme.getVoteList().add(vote);
        programme =  programmeService.saveProgramme(programme);
        vote.setProgramme(programme);
        voteService.saveVote(vote);
        return voteMapper.fromEntity(vote);
    }
}
