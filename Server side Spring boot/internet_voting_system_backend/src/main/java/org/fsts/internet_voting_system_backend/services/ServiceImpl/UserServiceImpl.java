package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@Service
public class UserServiceImpl implements UserService {
    private final UserAppRepository userAppRepository;
    @Override
    public UserApp saveUser(UserApp userApp) {
        userApp.setUserId(UUID.randomUUID().toString());
        return userAppRepository.save(userApp);
    }

    @Override
    public UserApp updateUser(UserApp userApp) {
        return userAppRepository.save(userApp);
    }

    @Override
    public List<UserApp> getAllUsers() {
        return userAppRepository.findAll();
    }
}
