package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Vote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VoteRepository extends JpaRepository<Vote, String> {

    List<Vote> findVoteByProgramme(Programme programme);
}
