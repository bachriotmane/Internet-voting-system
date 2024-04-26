package org.fsts.internet_voting_system_backend.DTOs;

public record AuthenticationDTO(
        String username,
        String password,
        boolean withRefreshToken,
        String refreshToken,
        String grantType
) {}