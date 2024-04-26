package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Vote;

import java.util.List;

public interface VoteService {
    public Vote saveVote(Vote vote);
    public List<Vote> getAllVotes();
}
