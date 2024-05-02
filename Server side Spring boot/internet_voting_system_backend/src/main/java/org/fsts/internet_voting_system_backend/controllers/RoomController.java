package org.fsts.internet_voting_system_backend.controllers;


import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.RoomDTO;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.mappers.RoomMapper;
import org.fsts.internet_voting_system_backend.services.RoomService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;


@RestController("/rooms")
@AllArgsConstructor
public class RoomController {
    public final UserService userService;
    public final RoomService roomService;
    public final RoomMapper roomMapper;

    @GetMapping("/")
    public ResponseEntity<?>  getAllRooms(){
        Optional<List<Room>>  rooms = roomService.getAllRoom();

        if(rooms.isPresent())
        {
            List<RoomDTO> roomDTOS = rooms.get().stream().map(roomMapper::fromEntity).toList();
            return new  ResponseEntity<>(roomDTOS,HttpStatus.OK);
        }
        else {
            return new ResponseEntity<>("No Rooms Available ",HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getCraetedRooms(@PathVariable("userId") String userId)
    {
        Optional<List<Room>> rooms = userService.getCreatedRooms(userId);
        if(rooms.isPresent())
        {
            List<RoomDTO> roomDTOS = rooms.get().stream().map(roomMapper::fromEntity).toList();
            return new ResponseEntity<>(roomDTOS, HttpStatus.OK);
        }
        else {
            return new ResponseEntity<>("there is no rooms with this user id ",HttpStatus.NOT_FOUND);
        }


    }
    @GetMapping("/search")
    public ResponseEntity<?> getRoomsByKey(@RequestParam("key") String key)
    {
        Optional<List<Room>> rooms = roomService.getRoomsByKeyword(key);
       if(rooms.isPresent())
       {

           List<RoomDTO> roomDTOS = rooms.get().stream().map(roomMapper::fromEntity).toList();
           return new ResponseEntity<>(roomDTOS, HttpStatus.OK);
       }
       else {
           return new ResponseEntity<>("there is no rooms with the title ",HttpStatus.NOT_FOUND);
       }


    }
}
