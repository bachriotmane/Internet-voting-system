package org.fsts.internet_voting_system_backend.entities;



import jakarta.persistence.*;
import lombok.*;
import org.fsts.internet_voting_system_backend.enums.UserRole;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class RoleApp {
    @Id
    private String idRole;

    @Enumerated(EnumType.STRING)
    private UserRole role;
}
