package org.fsts.internet_voting_system_backend.exceptions;

public class RefreshTokenExpiredException extends Exception{
    public RefreshTokenExpiredException(String message){
        super(message);
    }
}
