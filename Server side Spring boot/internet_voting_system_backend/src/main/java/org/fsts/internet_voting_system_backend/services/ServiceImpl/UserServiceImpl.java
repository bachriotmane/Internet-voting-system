package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.DTOs.AuthenticationDTO;
import org.fsts.internet_voting_system_backend.entities.RoleApp;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Validation;
import org.fsts.internet_voting_system_backend.enums.UserRole;
import org.fsts.internet_voting_system_backend.exceptions.ActivationException;
import org.fsts.internet_voting_system_backend.exceptions.RefreshTokenExpiredException;
import org.fsts.internet_voting_system_backend.repositories.RoleAppRepository;
import org.fsts.internet_voting_system_backend.repositories.UserAppRepository;
import org.fsts.internet_voting_system_backend.services.JwtService;
import org.fsts.internet_voting_system_backend.services.UserService;
import org.fsts.internet_voting_system_backend.services.ValidationService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@AllArgsConstructor
@Service
public class UserServiceImpl implements UserService, UserDetailsService {
    private final UserAppRepository userAppRepository;
    private final ValidationService validationService;
    private final JwtService jwtService;
    private final RoleAppRepository roleRepository;
    @Override
    public UserApp saveUser(UserApp userApp) {
        userApp.setUserId(UUID.randomUUID().toString());
        return userAppRepository.save(userApp);
    }



    @Override
    public UserApp registerUser(UserApp userApp) {

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        RoleApp roleApp = new RoleApp();
        roleApp.setRole(UserRole.USER);
        roleApp.setIdRole(UUID.randomUUID().toString());
        roleApp = roleRepository.save(roleApp);

        List<RoleApp> roles = new ArrayList<>();
        roles.add(roleApp);
        userApp.setRoles(roles);

        String encodedPassword = passwordEncoder.encode(userApp.getPassword());
        userApp.setPassword(encodedPassword);
        userApp.setEnabled(false);
        UserApp userApp1 =  saveUser(userApp);
        System.out.println(userApp1.toString());
        validationService.addNewValidation(userApp1);
        return userApp1;

    }

    @Override
    public UserApp updateUser(UserApp userApp) {
        return userAppRepository.save(userApp);
    }

    @Override
    public List<UserApp> getAllUsers() {
        return userAppRepository.findAll();
    }

    @Override
    public void activationAccount(Map<String, String> activation) throws ActivationException {
        String code = activation.get("code");
        Validation validation = validationService.getValidationBuCode(code);
        if(Instant.now().isAfter(validation.getExpireAt())){
            throw new ActivationException("Code already expired!!");
        }
        UserApp user = validation.getUserApp();
        user.setEnabled(true);
        userAppRepository.save(user);
    }

    @Override
    public Map<String, String> connexion(AuthenticationDTO authenticationDTO) throws RefreshTokenExpiredException {
        return jwtService.generateToken(authenticationDTO);
    }

    @Override
    public UserApp getUserById(String userId) {
        return userAppRepository.findById(userId).orElseThrow(()->new RuntimeException("User with id "+ userId+" not found"));
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userAppRepository.findUserAppByUsername(username);
    }
}
