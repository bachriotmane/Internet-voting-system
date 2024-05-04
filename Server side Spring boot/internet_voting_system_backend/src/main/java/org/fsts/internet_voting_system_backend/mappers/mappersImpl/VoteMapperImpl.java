package org.fsts.internet_voting_system_backend.mappers.mappersImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.mappers.VoteMapper;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.stereotype.Component;


@AllArgsConstructor
@Component
public class VoteMapperImpl implements VoteMapper {
    private final UserService userService;
    private final ProgrammeService programmeService;

    @Override
    public Vote fomDTO(VoteDTO voteDTO){
        Vote vote = new Vote();
        vote.setVoteId(voteDTO.voteId());
        vote.setDateVote(voteDTO.voteDate());
        UserApp voter = userService.getUserById(voteDTO.voteId());
        vote.setVoter(voter);
        Programme programme = programmeService.getProgrammeById(voteDTO.programmeId()).get();
        vote.setProgramme(programme);
        return  vote;
    }

    @Override
    public VoteDTO fromEntity(Vote vote){
        return new VoteDTO(vote.getVoteId(), vote.getDateVote(), vote.getVoter().getUserId(), vote.getProgramme().getProgrammeId());
    }
}
