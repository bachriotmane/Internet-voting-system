package org.fsts.internet_voting_system_backend.DTOs;

import java.util.Date;

public record UserDTO(
        String userId,
        String username,
        String email,
        String password,
        int age,
        String nom,
        String prenom,
        String phoneNumber,
        String CIN,
        boolean isEnabled
) {
}

