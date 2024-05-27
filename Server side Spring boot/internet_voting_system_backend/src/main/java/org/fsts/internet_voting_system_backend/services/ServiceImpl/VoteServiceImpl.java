package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.fsts.internet_voting_system_backend.repositories.VoteRepository;
import org.fsts.internet_voting_system_backend.services.ProgrammeService;
import org.fsts.internet_voting_system_backend.services.VoteService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class VoteServiceImpl implements VoteService {
    private final VoteRepository voteRepository;
    private final ProgrammeService programmeService;

    @Override
    public Vote saveVote(Vote vote) {
        vote.setVoteId(UUID.randomUUID().toString());
        return voteRepository.save(vote);
    }

    @Override
    public List<Vote> getAllVotes() {
        return voteRepository.findAll();
    }

    @Override
    public Vote getVoteById(String voteId) {
        return voteRepository.findById(voteId).orElseThrow(()->new RuntimeException("Vote with id " + voteId+" not found"));
    }

    @Override
    public Vote updateVote(Vote vote) {
        return voteRepository.save(vote);
    }

    @Override
    public List<Vote> getVoteParProgramme(String programmeId) {

        return voteRepository.findVoteByProgramme(programmeService.getProgrammeById(programmeId).get());
    }


    @Override
    @Transactional
    public void deleteVoteById(String id) {
        Vote vote = voteRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid vote ID"));
        Programme programme = vote.getProgramme();

        // Remove the vote from the programme's vote list
        if (programme != null) {
            programme.getVoteList().remove(vote);
            programmeService.updateProgramme(programme);
        }

        // Remove the association from the vote to prevent orphaned data
        vote.setProgramme(null);
        voteRepository.save(vote);

        // Finally, delete the vote
        voteRepository.deleteById(id);
    }
}
