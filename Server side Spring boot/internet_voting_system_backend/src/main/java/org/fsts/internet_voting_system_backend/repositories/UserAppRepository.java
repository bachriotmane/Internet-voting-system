package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserAppRepository extends JpaRepository<UserApp,String> {
    public UserApp findUserAppByUsername(String username);
    public Optional<List<Room>> getCreatedRoomsByUserId(String userId);
}
