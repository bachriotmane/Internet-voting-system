package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.UserApp;

import java.util.List;

public interface UserService {
    public UserApp saveUser(UserApp userApp);
    public UserApp updateUser(UserApp userApp);
    public List<UserApp> getAllUsers();
}
