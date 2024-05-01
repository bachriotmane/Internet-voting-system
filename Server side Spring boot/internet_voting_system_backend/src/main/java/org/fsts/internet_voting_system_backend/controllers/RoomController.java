package org.fsts.internet_voting_system_backend.controllers;


import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;


@RestController("/rooms")
@AllArgsConstructor
public class RoomController {
    public final UserService userService;
    public final RoomService roomService;

    @GetMapping("/")
    public ResponseEntity<?>  getAllRooms(){
        Optional<List<Room>>  rooms = roomService.getAllRoom();

        if(rooms.isPresent())
        {
            return new  ResponseEntity(rooms.get(),HttpStatus.OK);
        }
        else {
            return new ResponseEntity<>("No Rooms Available ",HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getCraetedRooms(@PathVariable String uderId)
    {
        Optional<List<Room>> rooms = userService.getCreatedRooms(uderId);
        if(rooms.isPresent())
        {
            return new ResponseEntity<>(rooms.get(), HttpStatus.OK);
        }
        else {
            return new ResponseEntity<>("there is no rooms with this user id ",HttpStatus.NOT_FOUND);
        }


    }
    @GetMapping("/search/{key}")
    public ResponseEntity<?> getRoomsByKey(@PathVariable String key)
    {
        Optional<List<Room>> rooms = roomService.getRoomsByKeyword(key);
       if(rooms.isPresent())
       {
           return new ResponseEntity<>(rooms.get(), HttpStatus.OK);
       }
       else {
           return new ResponseEntity<>("there is no rooms with the title ",HttpStatus.NOT_FOUND);
       }


    }
}
