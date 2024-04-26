package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserAppRepository extends JpaRepository<UserApp,String> {}
