package org.fsts.internet_voting_system_backend.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class Room {
    @Id
    private String roomId;
    private String title;
    private String roomDescription;
    private Date createAt;
    private Date startAt;
    private Date expireAt;
    private String code;

    @ManyToMany
    private List<UserApp> roomMembers;

    @ManyToOne
    private UserApp roomCreator;

    @OneToMany
    private List<Programme> programmeList;
}
