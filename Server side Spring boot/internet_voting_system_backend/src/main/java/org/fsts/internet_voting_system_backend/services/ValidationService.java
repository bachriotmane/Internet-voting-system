package org.fsts.internet_voting_system_backend.services;

import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Validation;

public interface ValidationService {
    public Validation addNewValidation(UserApp userApp);
    public Validation getValidationBuCode(String code);
}
