package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.Programme;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface RoomRepository extends JpaRepository<Room, String> {
    List<Room> findRoomsByRoomCreator(UserApp roomCreator);
    Optional<List<Room>> findByTitleContainingIgnoreCase(String keyword);
    public Optional<List<Room>> findByRoomCreatorUserId(String userId);

}
