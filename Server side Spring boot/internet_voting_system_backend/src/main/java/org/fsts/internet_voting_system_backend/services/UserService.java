package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.DTOs.AuthenticationDTO;
import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.Room;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.exceptions.ActivationException;
import org.fsts.internet_voting_system_backend.exceptions.RefreshTokenExpiredException;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface UserService extends UserDetailsService {
    public UserApp saveUser(UserApp userApp);
    public UserApp registerUser( UserApp userApp);
    public UserApp updateUser(UserApp userApp);
    public List<UserApp> getAllUsers();
    public void activationAccount(Map<String, String> code) throws ActivationException;
    public Map <String,String> connexion(AuthenticationDTO authenticationDTO) throws RefreshTokenExpiredException;
    public UserApp getUserById(String userId);
    public Optional<List<Room>> getCreatedRooms(String userId);
}
