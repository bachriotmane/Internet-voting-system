package org.fsts.internet_voting_system_backend.mappers.mappersImpl;

import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.mappers.UserMapper;
import org.springframework.stereotype.Component;

@Component
public class UserMapperImpl implements UserMapper {
    @Override
    public UserApp fromDTO(UserDTO userDTO){
        UserApp userApp = new UserApp();
        userApp.setUserId(userDTO.userId());
        userApp.setUsername(userDTO.username());
        userApp.setEmail(userDTO.email());
        userApp.setPassword(userDTO.password());
        userApp.setCIN(userDTO.CIN());
        userApp.setAge(userDTO.age());
        userApp.setEnabled(userDTO.isEnabled());
        userApp.setNom(userDTO.nom());
        userApp.setPrenom(userDTO.prenom());
        userApp.setPhoneNumber(userDTO.phoneNumber());
        return  userApp;
    }

    @Override
    public  UserDTO fromEntity(UserApp userAbs){
        return  UserDTO.builder()
                .userId(userAbs.getUserId())
                .username(userAbs.getUsername())
                .age(userAbs.getAge())
                .CIN(userAbs.getCIN())
                .email(userAbs.getEmail())
                .nom(userAbs.getNom())
                .phoneNumber(userAbs.getPhoneNumber())
                .prenom(userAbs.getPrenom())
                .build();
    }

}
