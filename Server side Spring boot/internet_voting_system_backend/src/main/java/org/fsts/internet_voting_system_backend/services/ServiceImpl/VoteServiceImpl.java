package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.repositories.VoteRepository;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class VoteServiceImpl implements VoteService {
    private final VoteRepository voteRepository;
    @Override
    public Vote saveVote(Vote vote) {
        vote.setVoteId(UUID.randomUUID().toString());
        return voteRepository.save(vote);
    }

    @Override
    public List<Vote> getAllVotes() {
        return voteRepository.findAll();
    }
}
