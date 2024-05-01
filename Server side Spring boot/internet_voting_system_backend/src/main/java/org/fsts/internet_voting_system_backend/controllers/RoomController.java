package org.fsts.internet_voting_system_backend.controllers;


import org.fsts.internet_voting_system_backend.entities.Room;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;



@RestController("/rooms")
public class RoomController {


    @GetMapping("/")
    public List<Room> getAllRooms(){
        return null;
    }
}
