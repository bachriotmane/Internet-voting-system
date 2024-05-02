package org.fsts.internet_voting_system_backend.controllers;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.mappers.UserMapper;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController("/user")
@AllArgsConstructor
public class UserController {

    private final UserAppRepository userService;
    private final UserMapper userMapper;


    @GetMapping("/{username}")
    public ResponseEntity<?> getUserByUsername(@PathVariable String username)
    {
        UserApp userApp = userService.findUserAppByUsername(username);

        if(userApp != null)
        {

            return new ResponseEntity<>(userMapper.fromEntity(userApp), HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("user not found !",HttpStatus.NOT_FOUND);
        }
    }
}
