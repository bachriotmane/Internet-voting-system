package org.fsts.internet_voting_system_backend.DTOs;

import lombok.ToString;

import java.util.Date;


public record VoteDTO(
        String voteId,
        Date voteDate,
        String voterId,
        String programmeId
) {
}
