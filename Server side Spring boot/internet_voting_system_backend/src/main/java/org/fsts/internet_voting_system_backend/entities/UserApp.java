package org.fsts.internet_voting_system_backend.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
public class UserApp {
    @Id
    private String userId;
    private String userName;
    private String email;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    private String nom;
    private String prenom;
    private String phoneNumber;
    private String CIN;
    private int age;
    @ManyToMany(mappedBy = "roomMembers")
    private List<Room> joiningRooms;

    @OneToMany(mappedBy = "roomCreator")
    private List<Room> createdRooms;



}
