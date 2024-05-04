package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.mappers.UserMapper;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/users")
@AllArgsConstructor
public class UserController {

    private final UserAppRepository userAppRepository;
    private final UserMapper userMapper;
    private final UserService userService;


    @GetMapping("/{username}")
    public ResponseEntity<?> getUserByUsername(@PathVariable String username)
    {
        UserApp userApp = userAppRepository.findUserAppByUsername(username);
        if(userApp != null)
        {
            return new ResponseEntity<>(userMapper.fromEntity(userApp), HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("user not found !",HttpStatus.NOT_FOUND);
        }
    }
    @PutMapping("/update")
    public ResponseEntity<?> updateUserInfo(@RequestBody UserDTO userDTO)
    {
        String id =userDTO.userId();
        if(id==null)
            return new ResponseEntity<>("User Id must be not null" , HttpStatus.BAD_REQUEST);

        Optional<UserApp> userApp=userService.getUserById(id);
        if(userApp.isEmpty())
            return new ResponseEntity<>("No user found with this id :"+id , HttpStatus.BAD_REQUEST);
        UserApp userToUpdate =userMapper.fromDTO(userDTO);
        UserApp updatedUser=userService.updateUser(userToUpdate);
        UserDTO updatedUserDTO=userMapper.fromEntity(updatedUser);
        return new ResponseEntity<>(updatedUserDTO, HttpStatus.OK);
    }
}
