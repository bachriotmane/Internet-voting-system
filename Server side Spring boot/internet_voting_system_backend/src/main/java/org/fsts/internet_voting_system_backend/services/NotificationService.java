package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.Validation;

public interface NotificationService {
    public void envoyerEmailVerificationUser(Validation validation);
}
