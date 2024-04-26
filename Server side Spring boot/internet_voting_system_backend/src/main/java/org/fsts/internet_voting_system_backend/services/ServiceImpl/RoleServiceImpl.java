package org.fsts.internet_voting_system_backend.services.ServiceImpl;

import lombok.AllArgsConstructor;
import org.fsts.internet_voting_system_backend.entities.RoleApp;
import org.fsts.internet_voting_system_backend.repositories.RoleAppRepository;
import org.fsts.internet_voting_system_backend.services.RoleService;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor
public class RoleServiceImpl implements RoleService {
    private final RoleAppRepository roleAppRepository;
    @Override
    public RoleApp saveRole(RoleApp roleApp) {
        roleApp.setIdRole(UUID.randomUUID().toString());
        return roleAppRepository.save(roleApp);
    }
}
