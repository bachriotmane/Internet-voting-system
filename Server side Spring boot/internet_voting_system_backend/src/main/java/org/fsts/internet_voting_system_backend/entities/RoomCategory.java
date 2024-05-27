package org.fsts.internet_voting_system_backend.entities;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Builder
@AllArgsConstructor
public class RoomCategory {
    @Id
    private String id;
    private String label;
}