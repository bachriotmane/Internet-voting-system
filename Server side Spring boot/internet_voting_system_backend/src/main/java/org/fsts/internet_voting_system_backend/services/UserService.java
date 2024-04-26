package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.DTOs.AuthenticationDTO;
import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.exceptions.ActivationException;
import org.fsts.internet_voting_system_backend.exceptions.RefreshTokenExpiredException;

import java.util.List;
import java.util.Map;

public interface UserService {
    public UserApp saveUser(UserApp userApp);
    public UserApp registerUser( UserApp userApp);
    public UserApp updateUser(UserApp userApp);
    public List<UserApp> getAllUsers();
    public void activationAccount(Map<String, String> code) throws ActivationException;
    public Map <String,String> connexion(AuthenticationDTO authenticationDTO) throws RefreshTokenExpiredException;
}
