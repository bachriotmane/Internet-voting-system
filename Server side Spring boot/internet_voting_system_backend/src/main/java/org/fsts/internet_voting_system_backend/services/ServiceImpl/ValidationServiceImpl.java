package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.UserApp;
import org.fsts.internet_voting_system_backend.entities.Validation;
import org.fsts.internet_voting_system_backend.repositories.ValidationRepository;
import org.fsts.internet_voting_system_backend.services.NotificationService;
import org.fsts.internet_voting_system_backend.services.ValidationService;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Random;

@AllArgsConstructor
@Service
public class ValidationServiceImpl implements ValidationService {
    private final ValidationRepository validationRepository;
    private final NotificationService notificationService;
    @Override
    public Validation addNewValidation(UserApp userApp) {
        Validation validation = new Validation();
        validation.setUserApp(userApp);
        validation.setCreatedAt(Instant.now());
        validation.setExpireAt(validation.getCreatedAt().plus(2, ChronoUnit.MINUTES));
        Random random = new Random();
        int r=random.nextInt(999999);
        String code = String.format("%06d",r);
        validation.setCode(code);
        Validation v = validationRepository.save(validation);
        notificationService.envoyerEmailVerificationUser(validation);
        return v;
    }

    @Override
    public Validation getValidationBuCode(String code) {
        return validationRepository.findValidationByCode(code);
    }
}
