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

@RestController("/user")
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
            return new ResponseEntity<>(userApp, HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("user not found !",HttpStatus.NOT_FOUND);
        }
    }
    @PutMapping("/update")
    public ResponseEntity<?> updateUserInfo(@RequestBody UserDTO userDTO)
    {
        UserApp userApp = userMapper.fromDTO(userDTO);
        userApp = userService.updateUser(userApp);
        UserDTO updatedUserDTO = userMapper.fromEntity(userApp);
        return new ResponseEntity<>(updatedUserDTO, HttpStatus.OK);
    }
}
