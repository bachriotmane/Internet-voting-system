package org.fsts.internet_voting_system_backend.controllers.auth;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.AuthenticationDTO;
import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.exceptions.ActivationException;
import org.fsts.internet_voting_system_backend.exceptions.RefreshTokenExpiredException;
import org.fsts.internet_voting_system_backend.mappers.UserMapper;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/authentication")
@AllArgsConstructor
public class AuthenticationController {
    private UserService userService;
    private final UserMapper userMapper = new UserMapper();
    @PostMapping("/register")
    public UserApp registerUser(@RequestBody UserDTO userApp){
        return userService.registerUser(userMapper.fromDTO(userApp));
    }

    @PostMapping("/activation")
    public ResponseEntity<String> activeAccount(@RequestBody Map<String , String> code){
        try{
            userService.activationAccount(code);
            return new ResponseEntity<String>("Activation a passed avec succes", HttpStatus.valueOf(200));
        }catch(ActivationException e){
            return new ResponseEntity<>(e.getMessage(), HttpStatusCode.valueOf(406));
        }catch(Exception e){
            return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    @PostMapping("/login")
    public Map<String, String> login(@RequestBody AuthenticationDTO authenticationInfo) throws RefreshTokenExpiredException {
        return userService.connexion(authenticationInfo);
    }

    @ExceptionHandler(RefreshTokenExpiredException.class)
    public ResponseEntity<Map<String, String>> handleRefreshTokenExpiredExcception (RefreshTokenExpiredException exception){
        return ResponseEntity.status(414).body(Map.of("error", exception.getMessage()));
    }

}