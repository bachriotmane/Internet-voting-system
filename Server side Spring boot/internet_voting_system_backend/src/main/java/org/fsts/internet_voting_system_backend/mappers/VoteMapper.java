package org.fsts.internet_voting_system_backend.mappers;

import org.fsts.internet_voting_system_backend.DTOs.VoteDTO;
import org.fsts.internet_voting_system_backend.entities.Vote;

public interface VoteMapper {
    public VoteDTO fromEntity(Vote vote);
    public Vote fomDTO(VoteDTO voteDTO);
}
