package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.DTOs.AuthenticationDTO;
import org.fsts.internet_voting_system_backend.exceptions.RefreshTokenExpiredException;

import java.util.Map;

public interface JwtService {
    public Map<String,String> generateToken(AuthenticationDTO authenticationDTO) throws RefreshTokenExpiredException;
}
