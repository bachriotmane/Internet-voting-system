package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.Vote;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteRepository extends JpaRepository<Vote, String> {
}
