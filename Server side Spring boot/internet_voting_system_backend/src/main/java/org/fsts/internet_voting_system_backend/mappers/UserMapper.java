package org.fsts.internet_voting_system_backend.mappers;

import org.fsts.internet_voting_system_backend.DTOs.UserDTO;
import org.fsts.internet_voting_system_backend.entities.UserApp;

public class UserMapper {
    public UserApp fromDTO(UserDTO userDTO){
        UserApp userApp = new UserApp();
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

    public  UserDTO fromEntity(UserApp userAbs){
        throw new RuntimeException("Otmane : I'm sorry I do not have time to implement this function try to do it! :)");
    }
}
