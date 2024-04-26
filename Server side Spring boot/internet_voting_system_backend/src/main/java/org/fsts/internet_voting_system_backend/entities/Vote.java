package org.fsts.internet_voting_system_backend.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
public class Vote {
    @Id
    private String voteId;
    private Date dateVote;
    @OneToOne
    private UserApp voter;
    @ManyToOne
    private Programme programme;
}
