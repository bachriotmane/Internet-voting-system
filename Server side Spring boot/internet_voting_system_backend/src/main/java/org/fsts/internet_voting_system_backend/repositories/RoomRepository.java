package org.fsts.internet_voting_system_backend.repositories;

import org.fsts.internet_voting_system_backend.entities.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<Room,String> {}
